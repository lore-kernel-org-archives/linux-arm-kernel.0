From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2011 18:05:36 +0000
Subject: [GIT PULL v3] Linux support for ARM LPAE
In-Reply-To: <20111208110349.GA26970@arm.com>
References: <20111208110349.GA26970@arm.com>
Message-ID: <20111208180536.GK14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 11:03:49AM +0000, Catalin Marinas wrote:
> The series is rebased against Will's idmap series as merged in your
> devel-stable tree (I couldn't fetch devel-stable this morning). Please
> note that the branch was changed to 'for-rmk' (previously 'for-next').
> The nopud fixup was already reordered so that it comes before your
> patch.

Thank you.

Now pulled and merged - with the expected conflict in ioremap.c between
your commits and 576d2f25 resolved.

I'll push it out shortly, so it should land in linux-next this evening.
