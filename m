From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Apr 2018 17:48:11 +0100
Subject: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180420164811.GC22369@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:

> The first 6 patches can be applied independently by subsystem
> maintainers.
> The last two patches depend on the first 6 patches, and are thus marked
> RFC.

Would it not make sense to try to apply everything en masse rather than
delaying?  I'm happy to apply the subsystem stuff but if it gets things
done quicker or more efficiently I'm also happy to have the lot merged
as one series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/af2e3e2a/attachment-0001.sig>
