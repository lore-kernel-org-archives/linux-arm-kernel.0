From: dcb314@hotmail.com (David Binderman)
Date: Mon, 14 Dec 2015 14:48:05 +0000
Subject: linux-4.4-rc5/arch/arm/kvm/emulate.c: minor bug report
Message-ID: <DUB128-W447E535904EF4165141E1B9CED0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.4-rc5/arch/arm/kvm/emulate.c:297]: (style) Variable 'new_spsr_value' is assigned a value that is never used.
[linux-4.4-rc5/arch/arm/kvm/emulate.c:332]: (style) Variable 'new_spsr_value' is assigned a value that is never used.

They both look like candidates for deletion to me.

Regards

David Binderman


 		 	   		  
