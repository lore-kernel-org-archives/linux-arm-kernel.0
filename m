From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 27 Nov 2012 10:46:12 +0530
Subject: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and
 OMAP4_KBD_SYSSTATUS
In-Reply-To: <20121126180158.GD14623@core.coreip.homeip.net>
References: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
 <20121126180158.GD14623@core.coreip.homeip.net>
Message-ID: <CAM=Q2cuU4J81s9E3o95MTFcp0fnbrrn-p65qGiJFOQTsiT-oqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 11:31 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com
> wrote:

> On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D wrote:
> > The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
> > so remove them.
>
> They document the existing registers and do not add bloat to the
> generated objects so let's leave them be.
>

The objective of the patch is not to prevent bloat.

Actually these registers have power/system impact so it was decided that
the drivers will not
configure the sysc registers (infact not define). Currently hwmod
configures the registers.

To be safe I thought of deleting it.


> Thanks.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/f77ed45e/attachment.html>
