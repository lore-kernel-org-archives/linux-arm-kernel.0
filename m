From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 29 Jun 2012 12:01:19 +0530
Subject: [PATCH v2] clk: Add support for rate table based dividers
In-Reply-To: <20120627180635.GH22766@gmail.com>
References: <1340794893-20869-1-git-send-email-rnayak@ti.com>
 <20120627162851.GT1623@pengutronix.de> <20120627180635.GH22766@gmail.com>
Message-ID: <4FED4BB7.6070706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> After thinking about it a bit more I still think a separate
> clk_register_divider_table is needed.  Primarily this would reduce
> needless churn in having to update all existing users of
> clk_register_divider.  I also think that clearly separating the two
> functions will make it a bit easier on folks trying to port their clocks
> trees over.
>
> Unless there is a technical reason why having two registration functions
> is a bad idea, can you send a V4 with that new registration function?
> I'll take it into clk-next.
>
Nope, no technical reason why it can't be done. I'll do what you
suggested and post a v4 soon.

thanks,
Rajendra
