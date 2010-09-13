From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 13 Sep 2010 10:43:48 +0200
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <4C8DD588.7040009@endruntechnologies.com>
References: <4C8DD588.7040009@endruntechnologies.com>
Message-ID: <201009131043.48688.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 13. z??? 2010 09:40:56 Bruce M. Penrod napsal(a):
> This seems like a pretty straightforward question, but extensive web
> searching hasn't shown a really clear, up-to-date answer.  The most
> recent info is circa 2004 and states that 4MB is the largest
> uncompressed ARM kernel that may be loaded.  Not being an ARM assembly
> guru (head.S baffles me), I'd like to know if that is still true in
> 2010, and if it is, why?
> 
> I'm having one hell of a time compiling a monolithic kernel and keeping
> it under 4M without leaving out some core networking features I need.
>  From my searching, it looks like x86 has either removed the limit or
> raised it to a much higher number.  It's not clear to me why a 32 bit
> processor would not be able to boot a kernel larger than 4 MB.

Hey, CCed Russell.

Btw. this shouldn't be true anymore. On the other hand, why do you need such a 
huge kernel?

It's not even possible to create kernel that big if you don't have some kind of 
initramfs in, right? Besides, you can use some kind of a compression, like LZMA 
or something to keep the size down.

Cheers
> 
> Bruce
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
