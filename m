From: hemantp@ti.com (Pedanekar, Hemant)
Date: Thu, 8 Sep 2011 06:51:19 +0530
Subject: [PATCH 3/3] TI814X: Create board support and enable build for
	TI8148 EVM
In-Reply-To: <878vqbpxin.fsf@ti.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
	<878vqbpxin.fsf@ti.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hilman, Kevin wrote on Tuesday, August 30, 2011 5:43 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch adds minimal support and build configuration for TI8148 EVM.
>> Also adds support for low level debugging on UART1 console on the EVM.
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> [...]
> 
>> +static void __init ti8148_init_early(void)
>> +{
>> +	omap2_init_common_infrastructure();
>> +	omap2_init_common_devices(NULL, NULL);
> 
> Note that this function no longer exists in mainline.
> 
> Kevin

Will fix this in v2.

Thanks.
   Hemant
