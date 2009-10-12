From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 12 Oct 2009 13:01:04 -0400
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
	<63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
	<20090918163111.GA2284@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42615@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7709@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7D84@mi8nycmail19.Mi8.com>
	<63386a3d0910120202u5144bc7ep6b2008a71089369e@mail.gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7EFD@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 12, 2009 2:02 AM, Linus Walleij wrote:
> 2009/10/9 H Hartley Sweeten <hartleys@visionengravers.com>:
>
>> This reorganizes the vic.c code in anticipation of a future patch
>> to use struct vic_device as the data stored in set_irq_chip_data().
> 
> I've tried to test this but I've got some real mangling problems when I
> bring up the raw mail, =20 =3D and =<newline> all over the place,
> I don't know if this is all my own fault, so that gmail mangles it.
> Can you send me a copy as an attachment that I can test?

Hello Linus,

Attached is the patch.  Hopefully it's gmail that's screwing it up...

Please see if this applies correctly.

Thanks,
Hartley
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vic_reorg2.patch
Type: application/octet-stream
Size: 9660 bytes
Desc: vic_reorg2.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091012/3798bda8/attachment-0001.obj>
