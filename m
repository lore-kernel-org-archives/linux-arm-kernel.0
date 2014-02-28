From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Feb 2014 10:53:10 +0900
Subject: [PATCH 2/4] ARM: dove: prepare new Dove DT Kconfig variable
In-Reply-To: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140228015310.GC9383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 10:28:03PM +0100, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE to mmc, thermal, wdt, and asoc Kconfigs.

I'd be much happier merging this sort of stuff individually through the
subsystems, we already have an annoying conflict here...  Is there some
bisection problem with doing that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/41d4daaa/attachment.sig>
