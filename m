From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Nov 2014 10:58:24 +0100
Subject: [PATCH 00/11] dmaengine: Cleanup chancnt
In-Reply-To: <20141106060653.GT1870@intel.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141106060653.GT1870@intel.com>
Message-ID: <20141106095824.GH2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 11:36:53AM +0530, Vinod Koul wrote:
> On Thu, Oct 16, 2014 at 11:00:52AM +0200, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > As pointed out in the documentation thread [1], the chancnt variable
> > is filled during the driver registration in dma_async_device_register,
> > from the liste of channels that has been set.
> > 
> > This serie removes the occurences of the drivers that set it in their
> > probe function.
> 
> Applied all, thanks

Great, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/5cfa82fc/attachment.sig>
