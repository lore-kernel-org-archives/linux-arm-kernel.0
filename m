From: johnhlinn@gmail.com (John Linn)
Date: Tue, 12 Jun 2012 16:12:20 -0700
Subject: problems with external initramfs passed to device tree kernel
Message-ID: <CAB9O=CMADa26benQCkEoLOKKTGNeExjvFeVkFe4HLVi-W=o=Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm not sure this is specific to ARM, but that's what I'm on so I
thought I'd ask.  I'm also running a device tree kernel.  I've tried
it on 3.0 and 3.3 kernels.

I'm seeing where I have to remove CONFIG_BLK_DEV_RAM from the kernel
to get it to boot with an external initramfs image. It says the image
is not?good (junk in it), but it boots.  The same image boots fine
when built into the kernel using INITRAMFS_SOURCE, even with
BLK_DEV_RAM in the kernel.

I've done quite a bit of digging at the init/initramfs.c and it's not
obvious to me where the issue lies (user error probably).

Any thoughts would be appreciated.

Thanks,
John
