From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 16:58:27 +0100
Subject: [PATCH 1/1] ARM: kirkwood-ds112.dts: use unique machine name
In-Reply-To: <20160207192632.GA28121@lunn.ch> (Andrew Lunn's message of "Sun,
 7 Feb 2016 20:26:32 +0100")
References: <1454870066-3353-1-git-send-email-xypron.glpk@gmx.de>
 <20160207192632.GA28121@lunn.ch>
Message-ID: <87h9hj19ek.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heinrich,
 
 On dim., f?vr. 07 2016, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Feb 07, 2016 at 07:34:26PM +0100, Heinrich Schuchardt wrote:
>> Downstream packages like Debian flash-kernel use
>> /proc/device-tree/model
>> to determine which dtb file to install.
>> 
>> Hence each dts in the Linux kernel should provide a unique model
>> identifier.
>> 
>> Commit 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS
>> devices") created the new files kirkwood-ds111.dts and kirkwood-ds112.dts
>> using the same model identifier.
>> 
>> This patch provides a unique model identifier for the
>> Synology DiskStation DS112.
>> 
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Fixes: 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS devices")
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/fixes with the Fixes tag and Andrew Reviewed-by tag.

Thanks,

Gregory



>
>     Thanks
> 	Andrew	     
>
>> ---
>>  arch/arm/boot/dts/kirkwood-ds112.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
>> index bf4143c..b84af3d 100644
>> --- a/arch/arm/boot/dts/kirkwood-ds112.dts
>> +++ b/arch/arm/boot/dts/kirkwood-ds112.dts
>> @@ -14,7 +14,7 @@
>>  #include "kirkwood-synology.dtsi"
>>  
>>  / {
>> -	model = "Synology DS111";
>> +	model = "Synology DS112";
>>  	compatible = "synology,ds111", "marvell,kirkwood";
>>  
>>  	memory {
>> -- 
>> 2.1.4
>> 

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
