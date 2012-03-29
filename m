From: davidb@codeaurora.org (David Brown)
Date: Thu, 29 Mar 2012 15:31:36 -0700
Subject: [PATCH 03/17] ARM: mark const init data with __initconst instead
 of __initdata
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120329223136.GA1930@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:12:20PM +0200, Uwe Kleine-K?nig wrote:

>  arch/arm/mach-msm/board-msm8x60.c             |    2 +-
>  arch/arm/mach-msm/board-qsd8x50.c             |    4 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
