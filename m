From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Mar 2016 11:58:38 +0200
Subject: [PATCH 2/4] mfd: axp20x: Add AXP209 GPIO driver to the mfd
In-Reply-To: <20160321115410.GC4140@x1>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
 <20160321115410.GC4140@x1>
Message-ID: <20160329095838.GJ30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Mar 21, 2016 at 11:54:10AM +0000, Lee Jones wrote:
> On Wed, 09 Mar 2016, Maxime Ripard wrote:
> 
> > Now that we have a GPIO driver for the AXP209, we can add it to our MFD.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mfd/axp20x.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Applied, thanks.

There's still some discussions about the whole design of the driver,
can you drop that patch for now?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/f10cc88c/attachment.sig>
