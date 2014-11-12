From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Nov 2014 16:55:29 +0530
Subject: [PATCH v4 00/58] dmaengine: Implement generic slave
 capabilities retrieval
In-Reply-To: <20141106143349.GL2989@lukather>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141106143349.GL2989@lukather>
Message-ID: <20141112112529.GK24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 03:33:49PM +0100, Maxime Ripard wrote:
> Hi Vinod,
> 
> On Tue, Oct 28, 2014 at 10:25:15PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > As we discussed a couple of weeks ago, this is the third attempt at
> > creating a generic behaviour for slave capabilities retrieval so that
> > generic layers using dmaengine can actually rely on that.
> > 
> > That has been done mostly through two steps: by moving out the
> > sub-commands of the device_control callback, so that the dmaengine
> > core can then infer from that wether a sub-command is implemented, and
> > then by moving the slave properties, such as the supported buswidth,
> > to the structure dma_device itself.
> > 
> > Comments are as usual appreciated!
> 
> How can we move forward on this?
> 
> I didn't have any comments on this version, and gathered quite a lot
> of Acked-by already.
> 
> Do you want me to rebase on top of your current next branch and send
> you a pull request?

Hi Maxime,

Thanks for the huge cleanup work

I quickly looked thru the series and looks okay. I will do a detailed review
in next couple of days and then host it on a topic branch so that Feng's
robot can test it before merging it.

Thanks

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/f5c4d3bf/attachment.sig>
