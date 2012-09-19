From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 19 Sep 2012 16:36:46 -0500
Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
In-Reply-To: <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
 <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
 <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
Message-ID: <505A3AEE.8060408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/2012 4:26 PM, Paul Walmsley wrote:
> Hi Beno?t
>
> On Wed, 19 Sep 2012, Cousson, Benoit wrote:
>
>> Thanks for the rebase / repost. I'll pulled the full series if Paul is OK with
>>    ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
>>
>> Paul,
>> Is that OK?
>
> Looks to me like the clock change is unrelated to the DTS changes?  Best
> thing would be if you could just take the DTS changes and I'll take the
> clkdev alias change.

Good point, it can be separated.

> Otherwise if that doesn't work I can ack it, but there might be some
> conflicts with other clkdev data changes.

No problem, that's fine for me.

Regards,
Benoit
