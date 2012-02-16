From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 16 Feb 2012 19:20:23 +0100
Subject: [PATCH] ARM: amba: don't include <asm/sizes.h>
In-Reply-To: <20120216172551.GA31306@merkur.ravnborg.org>
References: <20120216172551.GA31306@merkur.ravnborg.org>
 <20120216160525.GA30558@mail.gnudd.com>
Message-ID: <20120216182023.GA18485@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It would be good to have it included for all architectures.
> It really has nothing arch specific in it so it ought to live in
> include/linux:
> 
>     git mv include/asm-generic include/linux

Ok. I can do this if it has any chance to be accepted.  I find more
and more SZ_4K as I dig into my PCIe-AMBA bridge.

/alessandro
