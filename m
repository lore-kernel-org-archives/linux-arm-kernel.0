From: balbi@ti.com (Felipe Balbi)
Date: Sun, 17 Mar 2013 21:33:21 +0200
Subject: Linux 3.8.3
In-Reply-To: <CAE8XmWoYXyNFQ14e6X+2rkWQyRA=kSdc4J+DNu2Sv+6e9rvZRg@mail.gmail.com>
References: <20130314184702.GA17860@kroah.com>
 <CAE8XmWoYXyNFQ14e6X+2rkWQyRA=kSdc4J+DNu2Sv+6e9rvZRg@mail.gmail.com>
Message-ID: <20130317193321.GA15102@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 17, 2013 at 10:00:08PM +0800, Dongsheng Song wrote:
> On Fri, Mar 15, 2013 at 2:47 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > I'm announcing the release of the 3.8.3 kernel.
> >
> > All users of the 3.8 kernel series must upgrade.
> >
> > The updated 3.8.y git tree can be found at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.8.y
> > and can be browsed at the normal kernel.org git web browser:
> >         http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> >
> > thanks,
> >
> > greg k-h
> 
> Hi,
> 
> ?make ARCH=arm menuconfig?  no complains,  but "make ARCH=arm
> CROSS_COMPILE=arm-linux-gnueabihf-" failed:
> 
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CHK     kernel/config_data.h
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
>   Building modules, stage 2.
>   MODPOST 1904 modules
> ERROR: "flush_tlb_kernel_range" [drivers/staging/zsmalloc/zsmalloc.ko]
> undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Please find the attachment with .config.gz file.

linux-arm-kernel might have more information about this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130317/95e4f464/attachment.sig>
