From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 26 Jan 2011 15:32:40 -0800
Subject: [PATCH] msm: smd: Add smd_pkt driver
In-Reply-To: <8yatygweqng.fsf@huya.qualcomm.com>
References: <1292437675-11561-1-git-send-email-nvishwan@codeaurora.org>
	<8yatygweqng.fsf@huya.qualcomm.com>
Message-ID: <20110126153240.9cc6c2e2.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jan 2011 11:20:51 -0800
David Brown <davidb@codeaurora.org> wrote:

> On Wed, Dec 15 2010, Niranjana Vishwanathapura wrote:
> 
> > Add smd_pkt driver which provides device interface
> > to smd packet ports.
> >
> > Signed-off-by: Niranjana Vishwanathapura <nvishwan@codeaurora.org>
> > ---
> >  drivers/char/Kconfig       |    8 +
> >  drivers/char/Makefile      |    2 +
> >  drivers/char/msm_smd_pkt.c |  466 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 476 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/char/msm_smd_pkt.c
> 
> Andrew, what's the proper destination for this change?  Should this go
> into your tree?  Is there anything you want me to do with this change?
> 

Looks OK, I grabbed it.

I read the entire email trying to work out what an "SMD" is.  Failed. 
Oh well.
