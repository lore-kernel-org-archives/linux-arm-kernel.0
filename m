From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Nov 2014 15:33:49 +0100
Subject: [PATCH v4 00/58] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141106143349.GL2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Tue, Oct 28, 2014 at 10:25:15PM +0100, Maxime Ripard wrote:
> Hi,
> 
> As we discussed a couple of weeks ago, this is the third attempt at
> creating a generic behaviour for slave capabilities retrieval so that
> generic layers using dmaengine can actually rely on that.
> 
> That has been done mostly through two steps: by moving out the
> sub-commands of the device_control callback, so that the dmaengine
> core can then infer from that wether a sub-command is implemented, and
> then by moving the slave properties, such as the supported buswidth,
> to the structure dma_device itself.
> 
> Comments are as usual appreciated!

How can we move forward on this?

I didn't have any comments on this version, and gathered quite a lot
of Acked-by already.

Do you want me to rebase on top of your current next branch and send
you a pull request?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/c8884e51/attachment.sig>
