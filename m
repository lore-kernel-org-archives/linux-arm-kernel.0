From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 21:26:29 +0000 (UTC)
Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
In-Reply-To: <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
 <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1209192124570.5264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t

On Wed, 19 Sep 2012, Cousson, Benoit wrote:

> Thanks for the rebase / repost. I'll pulled the full series if Paul is OK with
>   ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
> 
> Paul,
> Is that OK?

Looks to me like the clock change is unrelated to the DTS changes?  Best 
thing would be if you could just take the DTS changes and I'll take the 
clkdev alias change.  

Otherwise if that doesn't work I can ack it, but there might be some 
conflicts with other clkdev data changes.


- Paul
