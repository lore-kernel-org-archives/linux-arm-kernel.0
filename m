From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 13 Nov 2014 21:00:55 +0530
Subject: [PATCH v4 00/58] dmaengine: Implement generic slave
 capabilities retrieval
In-Reply-To: <20141112131502.GN14919@lukather>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141106143349.GL2989@lukather> <20141112112529.GK24582@intel.com>
 <20141112131502.GN14919@lukather>
Message-ID: <20141113153055.GN24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 02:15:02PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Nov 12, 2014 at 04:55:29PM +0530, Vinod Koul wrote:
> > On Thu, Nov 06, 2014 at 03:33:49PM +0100, Maxime Ripard wrote:
> > > Hi Vinod,
> > > 
> > > On Tue, Oct 28, 2014 at 10:25:15PM +0100, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > As we discussed a couple of weeks ago, this is the third attempt at
> > > > creating a generic behaviour for slave capabilities retrieval so that
> > > > generic layers using dmaengine can actually rely on that.
> > > > 
> > > > That has been done mostly through two steps: by moving out the
> > > > sub-commands of the device_control callback, so that the dmaengine
> > > > core can then infer from that wether a sub-command is implemented, and
> > > > then by moving the slave properties, such as the supported buswidth,
> > > > to the structure dma_device itself.
> > > > 
> > > > Comments are as usual appreciated!
> > > 
> > > How can we move forward on this?
> > > 
> > > I didn't have any comments on this version, and gathered quite a lot
> > > of Acked-by already.
> > > 
> > > Do you want me to rebase on top of your current next branch and send
> > > you a pull request?
> > 
> > Hi Maxime,
> > 
> > Thanks for the huge cleanup work
> > 
> > I quickly looked thru the series and looks okay. I will do a detailed review
> > in next couple of days and then host it on a topic branch so that Feng's
> > robot can test it before merging it.
> 
> I know that it will break, because of the Atmel's XDMAC driver that
> has been merged since. This is why I mentionned rebasing it ;)
Okay then pls resend :)
I will keep couple of days reserved next week for it so that we merge it
quickly

> 
> FWIW, the branch I was using for this serie has been published like 3
> weeks ago, and my git repo is built by Feng's bot, so there shouldn't
> be any compiling issues.
Thats good indeed :)

-- 
~Vinod

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/6339ba64/attachment.sig>
