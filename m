From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 29 May 2017 11:27:46 +0300
Subject: [PATCH] ARM: dts: am43xx-clocks: Add support for CLKOUT2
In-Reply-To: <20170526155212.GG3717@atomide.com>
References: <20170524084341.16698-1-peter.ujfalusi@ti.com>
 <20170526155212.GG3717@atomide.com>
Message-ID: <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/17 18:52, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170524 01:47]:
>> Add the needed clock nodes for the CLKOUT2 to be usable by boards.
>
> Tero, care to ack?

I can't test the actual clock itself but the patch looks fine based on 
TRM, and doesn't seem to cause any issues either so:

Acked-by: Tero Kristo <t-kristo@ti.com>
