From: schen@mvista.com (Steve Chen)
Date: Wed, 26 May 2010 14:41:34 -0500
Subject: using openocd + gdb to debug linux kernel on arm926ejs
In-Reply-To: <4BFD72AD.4010005@gmail.com>
References: <4BFD72AD.4010005@gmail.com>
Message-ID: <AANLkTikwrs3PUS2zNR8daxfVkSCKLUvRtDYkXicXcTXq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 2:12 PM, f. achkar <fachkar.datawind@gmail.com> wrote:
> hi,
> This is my second posting (I'm not sure the first one passed the filter) sorry for that ...
>
> I'm newbie and have a s3c2450 based board (arm926ejs), I have a working compressed kernel image
> zImage, this image boots properly via u-boot-1.1.6, however I simply
> failed to debug remotely the vmlinux (root directory of linux source tree) via openocd-0.4.0 with a j-link segger.
> is there a good reference on how to properly debug the linux kernel via openocd/gdb for an arm target on a linux hot machine?

Actually, Nicolas Pitre posted an response in your first try.  In
summary, use uImage for uboot.  vmlinux won't work.

Regards,

Steve
