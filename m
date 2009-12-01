From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 01 Dec 2009 18:29:50 +0000
Subject: Disabling MMU Option for arm946E processor
In-Reply-To: <6edb5f450911262030g46cdf564j27ccad2297e71fe3@mail.gmail.com>
References: <6edb5f450911262030g46cdf564j27ccad2297e71fe3@mail.gmail.com>
Message-ID: <1259692190.2121.235.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-11-27 at 04:30 +0000, Girish KS wrote:
>         I am new to linux platform.I am porting linux kernel 2.6.31.6
>         to a 946E based (non MMU) board. The config option MMU for
>         kernel version 2.6.31.6 is defaulted to y. How can i override
>         this option without changing the arch/arm/Kconfig. 

Commit 3c4279750c7d3f88a0638a44e257d7d8d10732f2 was merged in
2.6.32-rc1. You may want to try the latest -rc kernel as it has several
patches for no-MMU support.

-- 
Catalin
