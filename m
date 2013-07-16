From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 16 Jul 2013 15:12:50 +0200
Subject: [PATCH v2 4/4] ARM: OMAP2+: Provide alias to USB PHY clock
In-Reply-To: <51E40199.9070906@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com>
 <1371571487-14389-5-git-send-email-rogerq@ti.com>
 <51E40199.9070906@ti.com>
Message-ID: <51E546D2.6000100@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 04:05 PM, Roger Quadros wrote:
> Hi Tony,
>
> On 06/18/2013 07:04 PM, Roger Quadros wrote:
>> Till the OMAP clocks are correctly defined in device tree, use
>> this temporary hack to provide clock alias to the USB PHY clocks.
>>
>> Without this, USB Host & Ethernet will not be functional with
>> device tree boots on Panda and uEVM.
>
> Looks like this one got missed out.

Could it be because you promised to resend it (see [1]). I was upgrading 
our test stuff to 3.11-rc1 and made a DT appended image. Boot went fine, 
but no USB/ethernet. Should I pickup all four patches?

Regards,
Arend

[1] http://mid.gmane.org/51C2EC5F.8050703 at ti.com

> USB host no longer works on Panda with DT boot.
> Could you please queue this for next 3.11-rc? Thanks.
>
> cheers,
> -roger
>
