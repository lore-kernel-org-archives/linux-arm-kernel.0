From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 10:43:56 +0100
Subject: [PATCH 03/19] i2c: sh_mobile: Enable the driver on all ARM
 platforms
In-Reply-To: <20131029050337.GB2643@katana>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029050337.GB2643@katana>
Message-ID: <2015733.JNqH7MboLG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tuesday 29 October 2013 06:03:37 Wolfram Sang wrote:
> On Tue, Oct 29, 2013 at 12:46:51AM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c at vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I wonder if those two Kconfig patches couldn't be squashed, but other
> than that:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thank you. Please feel free to squash the patches together when applying if 
needed.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/3d91fcf8/attachment.sig>
