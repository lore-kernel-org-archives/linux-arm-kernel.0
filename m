From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 06 Jan 2011 09:39:02 -0800
Subject: [PATCH 1/1] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <1294259965.2179.23.camel@koala>
References: <1293785680-19850-1-git-send-email-mnalajal@codeaurora.org>
	<1294216917.2179.11.camel@koala>
	<1294247531.16744.0.camel@c-dwalke-linux.qualcomm.com>
	<1294259965.2179.23.camel@koala>
Message-ID: <1294335542.24440.4.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-05 at 22:39 +0200, Artem Bityutskiy wrote:
> On Wed, 2011-01-05 at 09:12 -0800, Daniel Walker wrote:
> > On Wed, 2011-01-05 at 10:41 +0200, Artem Bityutskiy wrote:
> > > On Fri, 2010-12-31 at 14:24 +0530, Murali Nalajala wrote:
> > > > From: Arve Hj?nnev?g <arve@android.com>
> > > > 
> > > > Add initial msm nand driver support for Qualcomm MSM and QSD platforms.
> > > > This driver is currently capable of handling 2K page nand devices.
> > > > 
> > > > This driver is originally
> > > > developed by Google and its source is available at
> > > > http://android.git.kernel.org/?p=kernel/experimental.git
> > > > 
> > > > CC: Brian Swetland <swetland@google.com>
> > > > Signed-off-by: Arve Hj?nnev?g <arve@android.com>
> > > > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > > 
> > > Pushed to l2-mtd-2.6.git.
> > 
> > This patch had incorrect authorship .. Can you replace it with the
> > second one that was sent ?
> 
> Yes, I did that actually, noticed the second one later.

Is it too late for you to drop this ? It's got some additional issues
that we need some time to address ..

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
