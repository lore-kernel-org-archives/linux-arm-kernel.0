From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Nov 2014 14:51:31 +0100
Subject: [PATCH 00/11] dmaengine: Cleanup chancnt
In-Reply-To: <20141016090346.GE1638@intel.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141016090346.GE1638@intel.com>
Message-ID: <20141105135131.GA2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Thu, Oct 16, 2014 at 02:33:46PM +0530, Vinod Koul wrote:
> On Thu, Oct 16, 2014 at 11:00:52AM +0200, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > As pointed out in the documentation thread [1], the chancnt variable
> > is filled during the driver registration in dma_async_device_register,
> > from the liste of channels that has been set.
> > 
> > This serie removes the occurences of the drivers that set it in their
> > probe function.
> Barring the typos in the cover letter, series looks fine.

It's been 3 weeks already, and there's been no reviews justifying to
send a second version of the patch set.

Can we merge this in?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/665c1e30/attachment.sig>
