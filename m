From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 10 Jan 2011 09:33:30 -0800
Subject: [PATCH 4/5 v4] msm: convert 7x30 to gpiomux.
In-Reply-To: <AANLkTikrLnGxNSJgv3KDNAQ5kvjNd8aPrOEBwftiiyrQ@mail.gmail.com>
References: <1283015148-10747-1-git-send-email-gbean@codeaurora.org>
	<1283015148-10747-4-git-send-email-gbean@codeaurora.org>
	<AANLkTikrLnGxNSJgv3KDNAQ5kvjNd8aPrOEBwftiiyrQ@mail.gmail.com>
Message-ID: <1294680810.12298.2.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-01-09 at 14:53 -0800, Dima Zavin wrote:
> Greg,
> 
> Just rebased on top of 2.6.37 and this patch is totally the wrong way
> to go about this.
> 
> I should have commented at the appropriate time, so sorry for the late reply.
> 
> Having this  msm_gpiomux_configs be always compiled in for all msm7x30
> devices makes this entire system completely inflexible since you have
> to modify common code to provide board specific initialization. The
> definition of "msm_gpiomux_configs" belongs in the board file, not in
> gpiomux-7x30.c. I think we need to delete this new file and move the
> definition back into board-msm7x30.c, but just use the new gpiomux
> APIs.
> 
> I can provide a patch if you like.

I would just provide the patch .. It would be easier to understand what
your talking about.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
