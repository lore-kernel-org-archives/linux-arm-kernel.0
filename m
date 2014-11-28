From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 14:53:08 +0100
Subject: [PATCH] mmc: atmel-mci: use probe deferring if dma controller is
 not ready yet
In-Reply-To: <CAPDyKFr5GBuWW4UxvAKz6++Qc=wACtn-+c4_s0tNLLjL3mhhMA@mail.gmail.com>
References: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
 <1416925541-6857-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFr5GBuWW4UxvAKz6++Qc=wACtn-+c4_s0tNLLjL3mhhMA@mail.gmail.com>
Message-ID: <20141128135308.GF2714@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 12:09:47PM +0100, Ulf Hansson wrote:
> On 25 November 2014 at 15:25, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Return probe defer if requesting a dma channel without a dma controller
> > probed.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Hi Ulf,
> >
> > I didn't send the whole set of patches for this small change, tell me if you
> > want a new series.
> 
> I tried to apply the patchset and get two problems.
> 
> 1) This patch 4 has checkpatch errors.

Strange, I did it and I only had a 80 columns warning, I'll check if I
didn't do something wrong.

> 2) I hit conflicts on patch2.
> 

Ok I'll rebase it on your next branch.

> Please resend the complete patchset fixing the above.

Regards

Ludovic
