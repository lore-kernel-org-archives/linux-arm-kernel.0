From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 28 Oct 2015 11:41:04 -0700
Subject: [PATCH v2 3/3] mfd: lm3533: Support initialization from Device
 Tree
In-Reply-To: <20151028114057.GT5828@x1>
References: <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445963373-27790-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20151028114057.GT5828@x1>
Message-ID: <20151028184104.GC24668@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 28 Oct 04:40 PDT 2015, Lee Jones wrote:

> On Tue, 27 Oct 2015, Bjorn Andersson wrote:
> 
> > Implement Device Tree parsing functions to support initialization of the
> > lm3533 drivers.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> > 
> > Changes since v1:
> > - Added units to bost-freq and als resistance
> > 
> >  drivers/mfd/lm3533-core.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 264 insertions(+)
> 
> I assume you plan on fixing the build robot's complains? 
> 

I do, unfortunately I didn't get those on v1 :/


Just trying to conclude if I should move the logic from patch 2 into
this patch before resending.

Regards,
Bjorn
