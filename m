From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 17:59:08 +0000
Subject: [RFC part1 PATCH 2/7] ARM64 : Add dummy asm/cpu.h
In-Reply-To: <1386088611-2801-3-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203175908.GH27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 12:36:46AM +0800, Hanjun Guo wrote:
> ACPI requires a cpu.h, add a dummy one copied from arm. This will need
> updated or replaced as ACPI based cpu hotplug for armv8 is worked out.

We're going to need the same thing for CPU topology, I've got a similar
addition as part of a series to introduce that (which is going to want
an ACPI back end at some point I guess) at which point it'll stop being
a dummy.  I should be posting this week all being well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/456367d3/attachment.sig>
