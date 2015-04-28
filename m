From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 28 Apr 2015 21:24:57 +0200
Subject: [PATCH] arch/arm/mm/proc-arm925.S: remove dead #ifdef block
In-Reply-To: <1430239529-15726-1-git-send-email-valentinrothberg@gmail.com>
References: <1430239529-15726-1-git-send-email-valentinrothberg@gmail.com>
Message-ID: <1430249097.2411.74.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-28 at 18:45 +0200, Valentin Rothberg wrote:
> The block could never be compiled;  CPU_ICACHE_STREAMING_DISABLE has not
> been defined in Kconfig since the very first Git commit.

Actually, this goes back to a patch titled "1759/1: Add ARM925 support,
updated" that landed in v2.6.4.

When cleaning up ancient cruft like this it's fun, at least I think it
is, and possibly even informative, to have a Linux history repository at
hand. Feel free to prod me for details how to create such a repository.


Paul Bolle
