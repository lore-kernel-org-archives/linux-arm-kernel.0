From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 14 Jan 2011 13:08:21 -0800
Subject: [PATCH] ARM: msm: 7x30: don't force a gpiomux table for the
	whole arch
In-Reply-To: <4D2FC49A.1000505@codeaurora.org>
References: <1294680810.12298.2.camel@c-dwalke-linux.qualcomm.com>
	<1294686030-9817-1-git-send-email-dima@android.com>
	<4D2FC49A.1000505@codeaurora.org>
Message-ID: <1295039301.4129.14.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-13 at 19:35 -0800, Rohit Vaswani wrote:
> On 1/10/2011 11:00 AM, Dima Zavin wrote:
> > This is completely board specific and therefore must be provided
> > on a per-board basis.
> >
> > Change-Id: I96f922ad9bb9cbce7874c5ae6ac0d7479b7a2124
> > Signed-off-by: Dima Zavin<dima@android.com>
> >
> Tested-by: Rohit Vaswani <rvaswani@codeaurora.org>

Rohit, do you have patches to do this for all the SoCs?

Daniel


-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
