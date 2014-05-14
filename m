From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 08:49:54 +0200
Subject: [PATCH RESEND v4 3/8] phy: sunxi: Rework phy initialization
In-Reply-To: <537303C3.8040503@ti.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399995862-17788-4-git-send-email-maxime.ripard@free-electrons.com>
 <537303C3.8040503@ti.com>
Message-ID: <20140514064954.GF29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 11:18:51AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 13 May 2014 09:14 PM, Maxime Ripard wrote:
> > Move the phy initialization and variables declaration to the loop itself, since
> > it is where it really belongs. Also remove all the temporary variables, we can
> > use the structure members directly.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> let me know if I have to queue this and the next patch in my PHY tree.

Yes, that would be great

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/ef763420/attachment.sig>
