From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 13:16:45 +0100
Subject: [PATCH] ARM: mm: Remove Kconfig symbol CACHE_PL310
In-Reply-To: <1423562453.5346.18.camel@x220>
References: <1423562453.5346.18.camel@x220>
Message-ID: <4136777.yqkxmBgocn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 February 2015 11:00:53 Paul Bolle wrote:
> Commit 20e783e39e55 ("ARM: 8296/1: cache-l2x0: clean up aurora cache
> handling") removed the only user of the Kconfig symbol CACHE_PL310.
> Setting CACHE_PL310 is now pointless. Remove its Kconfig entry, and one
> select of this symbol.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Please note that the commit hash is valid for next-20150209. So if the
> tree that this commit is coming from will be rebased, or similar, it
> shouldn't be used.

Applied to the arm-soc fixes branch, which is top of the merges
that Linus has done and that includes my patch as it went in though
Russell's tree.

	Arnd
