From: peter.ujfalusi@ti.com (=?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?=)
Date: Tue, 30 Oct 2012 08:39:25 +0100
Subject: [PATCH] CLK: clk-twl6040: Initial clock driver for OMAP4+ McPDM
 fclk clock
In-Reply-To: <20121029173008.18780.35000@nucleus>
References: <1347633027-20731-1-git-send-email-peter.ujfalusi@ti.com>
 <20121029173008.18780.35000@nucleus>
Message-ID: <508F842D.8000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 10/29/2012 06:30 PM, Mike Turquette wrote:
> Peter,
> 
> The patch looks good to me.  To be clear, you wan this to go through
> clk-next or the mfd tree for avoiding conflicts?

clk-next is the best place for it I think. The MFD part to register the device
can still wait till we have ccf support on OMAP4.

Thank you,
P?ter
