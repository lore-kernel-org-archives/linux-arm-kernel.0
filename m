From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 17 May 2015 09:45:53 +0200
Subject: [PATCH v9] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150517094553.7fd8d8a0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Corentin,

On Thu, 14 May 2015 14:58:57 +0200
LABBE Corentin <clabbe.montjoie@gmail.com> wrote:

> 
> Hello
> 
> This is the driver for the Security System included in Allwinner SoC A20.
> The Security System (SS for short) is a hardware cryptographic accelerator that
> support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> It could be found on others Allwinner SoC: 
> - A10, A10s, A13, A31 and A33 manual give the same datasheet for SS than A20
> - A23 speak about a security system but without precisions
> - A80 and A83T datasheet speak about a security system with more functions
>   (SHA224/SHA256/RSA/CRC), they will be supported in a separate driver
> But I do not have access on any of those hardware, tests are welcome.
> 

Maybe this is just a nitpick, but I would reverse the ordering of
patches in this series. The biggest inconsistency is the fact that
you're adding yourself as a maintainer of something that does not even
exist.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
