From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Feb 2013 14:54:47 +0000
Subject: [PATCH 01/11] ARM: disable virt_to_bus/virt_to_bus almost
 everywhere
In-Reply-To: <512B72A7.6040307@synopsys.com>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <20130222101359.0c91a7259f648a3d06221bd8@canb.auug.org.au>
 <512B72A7.6040307@synopsys.com>
Message-ID: <201302251454.47617.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 February 2013, Vineet Gupta wrote:
> Have you queued up this change via one of your trees already for 3.9-rcX ?
> If not, I can fold it in with a bunch of Kconfig cleanups for ARC
> (GENERIC_SIGALTSTACK, HAVE_IRQ_WORK), given that those bits are already in linus'
> tree.
> 

I haven't put it in my tree yet, not. Please put it in yours.

	Arnd
