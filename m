From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Jan 2014 18:27:05 +0000
Subject: [PATCH v10 1/4] arm64: topology: Implement basic CPU topology
 support
In-Reply-To: <20140110174558.GI925@arm.com>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-2-git-send-email-broonie@kernel.org>
 <20140110174558.GI925@arm.com>
Message-ID: <20140110182705.GR29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 05:45:59PM +0000, Catalin Marinas wrote:

> The patches seem fine otherwise, apart from the last one which I
> won't merge until we get some real numbers.

As I previously said I am really concerned about diverging from what
arm32 has done here and the numbers don't seem any less real than the
ones we're using there (they were generated in an identical fashion).
Given the hardware availability for arm64 in general is limited and
likely to be even more so for big.LITTLE systems it seems like asking
for problems down the line to do something different.

Honestly I'm not sure there will ever be more real numbers that aren't
benchmarked at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/9baebcba/attachment.sig>
