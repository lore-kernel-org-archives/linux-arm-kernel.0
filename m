From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Nov 2014 09:26:20 +0100
Subject: [PATCH 5/9] rc: sunxi-cir: Add support for the larger fifo found
 on sun5i and sun6i
In-Reply-To: <20141120142856.16b6562d@recife.lan>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
 <1416498928-1300-6-git-send-email-hdegoede@redhat.com>
 <20141120142856.16b6562d@recife.lan>
Message-ID: <20141121082620.GJ24143@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Thu, Nov 20, 2014 at 02:28:56PM -0200, Mauro Carvalho Chehab wrote:
> Em Thu, 20 Nov 2014 16:55:24 +0100
> Hans de Goede <hdegoede@redhat.com> escreveu:
> 
> > Add support for the larger fifo found on sun5i and sun6i, having a separate
> > compatible for the ir found on sun5i & sun6i also is useful if we ever want
> > to add ir transmit support, because the sun5i & sun6i version do not have
> > transmit support.
> > 
> > Note this commits also adds checking for the end-of-packet interrupt flag
> > (which was already enabled), as the fifo-data-available interrupt flag only
> > gets set when the trigger-level is exceeded. So far we've been getting away
> > with not doing this because of the low trigger-level, but this is something
> > which we should have done since day one.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> As this is meant to be merged via some other tree:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

I think merging it through your tree would be just fine.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/be1a19cd/attachment.sig>
