From: lkundrak@v3.sk (Lubomir Rintel)
Date: Thu, 15 Nov 2018 19:57:44 +0100
Subject: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly
 non-modular"
In-Reply-To: <20181102221626.GC5322@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-3-lkundrak@v3.sk> <20181102221626.GC5322@amd>
Message-ID: <49eee45692f16dcbcf8aceaf3a999bb7f33178ba.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-02 at 23:16 +0100, Pavel Machek wrote:
> On Wed 2018-10-10 19:22:47, Lubomir Rintel wrote:
> > It doesn't make sense to always have this built-in, e.g. on ARM
> > multiplatform kernels. A better way to address the problem the
> > original
> > commit aimed to solve is to fix Kconfig.
> > 
> > This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.
> 
> This looks ok, but I don't see the Kconfig fix in the series. Is it
> needed?

It's flipped to a tristate in "Platform: OLPC: Move OLPC config symbol
out of x86 tree" and mentioned in the commit message.

Perhaps I could made that clear by separating the change into a
separate patch. I'm keeping it as it is in next version of the patch
set, but I'm going to improve this one's commit message and sort the
patches closer together.

> 							Pavel

Lubo								
