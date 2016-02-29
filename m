From: dcb314@hotmail.com (David Binderman)
Date: Mon, 29 Feb 2016 16:28:09 +0000
Subject: linux-4.5-rc6/arch/arm/nwfpe/softfloat.c: 2 * set but not used ?
Message-ID: <DUB128-W8426FAE8E44AA45DC988B9CBA0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

1.

[linux-4.5-rc6/arch/arm/nwfpe/softfloat.c:1362]: (style) Variable 'bSign' is assigned a value that is never used.

Source code is

??? bSign = extractFloat32Sign( b );

Suggest either delete the variable or use it someplace.

2.

[linux-4.5-rc6/arch/arm/nwfpe/softfloat.c:2258]: (style) Variable 'bSign' is assigned a value that is never used.

Duplicate.


Regards

David Binderman

 		 	   		  
