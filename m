From: martin@ronetix.at (Martin Peevski)
Date: Fri, 16 Nov 2012 12:26:47 +0200
Subject: Configure the USB device/host on sam9g25 module
In-Reply-To: <cc2fa961-1156-48b8-b805-6583df35e126@email.android.com>
References: <50A51978.7040001@ronetix.at>
 <cc2fa961-1156-48b8-b805-6583df35e126@email.android.com>
Message-ID: <50A614E7.9090308@ronetix.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again!
There were no problem, thank you for the time!


On 15/11/12 18:56, Zhong Li wrote:
> It is a hardware configuration problem. You must use a type-A mini USB 
> cable.
>
> Martin Peevski <martin@ronetix.at> wrote:
>
>            Hi,
>
>     I'm working with sam9g25 module placed on sam9x5-ek. sam9g25 has 2
>     host USB's and 1 device/host USB (on the micro USB of sam9x5-ek). Both
>     USB hosts accept mass storage devices and works correct. It was
>     impossible to do 2 things with the USB device/host (placed on the micro
>     USB of sam9x5-ek):
>
>     1. Put in it mass storage device - the kernel want not to
>     enumerate it and give it an name (for example sda, sdb, ...). What I
>     must do in the config file of kernel to be recognized the inserted mass
>     storage device?
>
>     2. Connect cable from the micro USB to any of the host USB's and
>     detect USB serial gadget.
>
>     I tryed to make some configs for both problems in the kernel but it
>     don't works. Can you, please, help me solve these problems?
>
>     ------------------------------------------------------------------------
>
>     linux-arm-kernel mailing list
>     linux-arm-kernel at lists.infradead.org
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/71176673/attachment-0001.html>
