From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Mar 2013 11:36:36 +0200
Subject: [PATCH 2/6] usb: otg: mv_otg: remove unused clock
In-Reply-To: <CADApbehYSCqrUkiMic3Qga4L3shFGOyHUr=THO=zadLb7ecr+w@mail.gmail.com>
References: <1363593333-6077-1-git-send-email-chao.xie@marvell.com>
 <1363593333-6077-3-git-send-email-chao.xie@marvell.com>
 <20130320130927.GT29659@arwen.pp.htv.fi>
 <CADApbehYSCqrUkiMic3Qga4L3shFGOyHUr=THO=zadLb7ecr+w@mail.gmail.com>
Message-ID: <20130321093636.GA11388@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:16:15PM +0800, Chao Xie wrote:
> On Wed, Mar 20, 2013 at 9:09 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Mar 18, 2013 at 03:55:29AM -0400, Chao Xie wrote:
> >> The origianl understanding of clock is wrong. The OTG controller
> >> only have one clock input.
> >> Passing clock name by pdata is wrong. The clock is defined by device
> >> iteself.
> >>
> >> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >
> > please rebase against my 'next' branch.
> >
> > --
> > balbi
> hi
> Do you mean git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git -
> branch "usb-next"?
> Or some other git?

from MAINTAINERS:

8293 USB GADGET/PERIPHERAL SUBSYSTEM
8294 M:      Felipe Balbi <balbi@ti.com>
8295 L:      linux-usb at vger.kernel.org
8296 W:      http://www.linux-usb.org/gadget
8297 T:      git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
8298 S:      Maintained
8299 F:      drivers/usb/gadget/
8300 F:      include/linux/usb/gadget*

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130321/358ad0cc/attachment-0001.sig>
