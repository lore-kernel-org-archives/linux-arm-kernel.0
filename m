From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 29 Oct 2013 11:03:12 -0500
Subject: [PATCH v3 08/10] mfd: pm8x41: add support for Qualcomm 8x41 PMICs
In-Reply-To: <20131029155605.GE4231@lee--X1>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <5a49bffc44c5f5bffe222560e489a712321ce971.1382985169.git.joshc@codeaurora.org>
 <20131029155605.GE4231@lee--X1>
Message-ID: <20131029160312.GA23929@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 08:56:05AM -0700, Lee Jones wrote:
> On Mon, 28 Oct 2013, Josh Cartwright wrote:
> 
> > The Qualcomm 8941 and 8841 PMICs are components used with the Snapdragon
> > 800 series SoC family.  This driver exists largely as a glue mfd component,
> > it exists to be an owner of an SPMI regmap for children devices
> > described in device tree.
> > 
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> >  drivers/mfd/Kconfig  | 10 ++++++++
> >  drivers/mfd/Makefile |  1 +
> >  drivers/mfd/pm8x41.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Can you CC me on your next submission, or it may not get applied.

Certainly.  Sorry about that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
