From: rogerq@ti.com (Roger Quadros)
Date: Tue, 18 Jun 2013 15:33:06 +0300
Subject: [PATCH 4/4] ARM: OMAP2+: dts: HACK: Provide alias to USB PHY clock
In-Reply-To: <20130618112342.GN5523@atomide.com>
References: <1371553891-29364-1-git-send-email-rogerq@ti.com>
 <1371553891-29364-5-git-send-email-rogerq@ti.com>
 <20130618112342.GN5523@atomide.com>
Message-ID: <51C05382.8090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2013 02:23 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130618 04:17]:
>> Till the OMAP clocks are correctly defined in device tree, use
>> this temporary hack to provide clock alias to the USB PHY clocks.
>>
>> Without this, USB Host & Ethernet will not be functional with
>> device tree boots on Panda and uEVM.
> 
> Thanks, this looks OK to me to have USB working until we have the
> DT defined clock patches ready.
> 
> The $Subject needs updating though, just make it ARM: OMAP2+: and
> leave out the dts and hack from there.
> 

OK. will send v2 as i need to make another minor change in the panda dts file.

cheers,
-roger
