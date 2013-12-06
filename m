From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Dec 2013 13:58:25 +0000
Subject: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
In-Reply-To: <201312052325.02603.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de>
Message-ID: <20131206135825.GG29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 11:25:02PM +0100, Arnd Bergmann wrote:

> However, as I mentioned before I am much more worried about the parts that
> are not done (or not posted) yet and that will be required to actually
> have working support for a real server system. Until we know more about
> where this is heading, I think we should not merge any of the ARM specific
> parts of your patches. Any patches that are reasonable cleanups and bug
> fixes for the ACPI subsystem should of course get merged once they are
> reviewed.

OTOH if it's well encapsulated, is going to be required for any kind of
ACPI use and gets to the point where people are OK with it by itself
then I'm not sure what we'd gain by keeping it out of tree - it'd make
the real system patch sets bigger and harder to review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/f0f0bbf6/attachment.sig>
