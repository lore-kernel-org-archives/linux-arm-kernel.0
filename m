From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 10 Mar 2016 12:38:13 +0300
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <201603101013.04618.arnd@arndb.de>
References: <201603101013.04618.arnd@arndb.de>
Message-ID: <CALT56yPDXkOvwQHngFsLkjgkyGx5HRNj8oddhFjTRdMbv5zvbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2016-03-10 12:13 GMT+03:00 Arnd Bergmann <arnd@arndb.de>:
> I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
> so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
> we currenly support in the Linux kernel.
>
> The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
> and it will be removed in the following release (gcc-7) one year later, unless someone
> raises concerns over it.

In which form should we raise concerns? Is it about stepping up as a
maintainers, or just
about telling them that platforms are used? My main concern with
limiting ARMv4 platforms
to older compilers would be that sooner or later we won't be able to
use newer kernels,
as the mainline will stop supporting older compilers.


-- 
With best wishes
Dmitry
