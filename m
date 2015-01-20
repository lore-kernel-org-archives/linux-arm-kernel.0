From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Jan 2015 09:10:38 -0600
Subject: [next-20150119]regression (mm)?
In-Reply-To: <CAOMZO5D-Z-FLPmQ4Yy3rxBa-FebLcnG9TSzg3F-MF-TFBBMrwQ@mail.gmail.com>
References: <54BD33DC.40200@ti.com> <20150119174317.GK20386@saruman>
 <20150120001643.7D15AA8@black.fi.intel.com>
 <20150120114555.GA11502@n2100.arm.linux.org.uk>
 <20150120140546.DDCB8D4@black.fi.intel.com>
 <CAOMZO5D-Z-FLPmQ4Yy3rxBa-FebLcnG9TSzg3F-MF-TFBBMrwQ@mail.gmail.com>
Message-ID: <20150120151038.GC6556@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 12:50:59PM -0200, Fabio Estevam wrote:
> On Tue, Jan 20, 2015 at 12:05 PM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > Russell King - ARM Linux wrote:
> >> On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
> >> > Better option would be converting 2-lvl ARM configuration to
> >> > <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.
> >>
> >> Well, IMHO the folded approach in asm-generic was done the wrong way
> >> which barred ARM from ever using it.
> >
> > Okay, I see.
> >
> > Regarding the topic bug. Completely untested patch is below. Could anybody
> > check if it helps?
> 
> Yes, it helps. Now I can boot mx6 running linux-next 20150120 with
> your patch applied.

worked fine here too with AM437x SK, AM437x IDK and BeagleBoneBlack.

thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/91a52db0/attachment.sig>
