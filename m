From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 17:30:20 +0100
Subject: [PATCH v2 04/13] ARM: timer-sp: convert to use CLKSRC_OF init
In-Reply-To: <1364854883-5961-5-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-5-git-send-email-robherring2@gmail.com>
Message-ID: <20130419163019.GX14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 05:21:14PM -0500, Rob Herring wrote:
> -void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
> -	const char *name)
> +void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)

This line is really too long.  That's why the previous wrapped it.  Please
do the same with yours.
