From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Nov 2014 09:51:07 +0100
Subject: [PATCH 4/9] rc: sunxi-cir: Add support for an optional reset
 controller
In-Reply-To: <20141120142831.003fb63e@recife.lan>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
 <1416498928-1300-5-git-send-email-hdegoede@redhat.com>
 <20141120142831.003fb63e@recife.lan>
Message-ID: <20141121085107.GM24143@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Thu, Nov 20, 2014 at 02:28:31PM -0200, Mauro Carvalho Chehab wrote:
> Em Thu, 20 Nov 2014 16:55:23 +0100
> Hans de Goede <hdegoede@redhat.com> escreveu:
> 
> > On sun6i the cir block is attached to the reset controller, add support
> > for de-asserting the reset if a reset controller is specified in dt.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> As this is meant to be merged via some other tree:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Again, I think it'll be perfectly fine in your tree :)

Once the documentation is updated,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/addae619/attachment.sig>
