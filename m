From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 23 Sep 2009 22:16:39 +0300
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <f17812d70909231203v198aafberd00ce35bd7ba7f6b@mail.gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
	<f17812d70909231203v198aafberd00ce35bd7ba7f6b@mail.gmail.com>
Message-ID: <200909232216.45173.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 23 ???????? 2009 22:03:17 ????? Eric Miao ???????:
> Sounds like there are cases where the pwm_enable() and pwm_disable()
> are not paired? You may want to print out the reference count each time
> to see if this is true.


I'm pretty sure they are paired, it's unlikely that it's pwm-bl bug.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090923/7afea097/attachment.sig>
