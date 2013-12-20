From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 19:55:09 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131217112914.GB32118@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
 <201312091820.23006.arnd@arndb.de> <20131209180155.GG19163@arm.com>
 <20131216205133.GI5617@xora-haswell.xora.org.uk>
 <20131217112914.GB32118@arm.com>
Message-ID: <20131220195509.GE31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 11:29:14AM +0000, Catalin Marinas wrote:

> - What if two hw vendors have different descriptors for the same device?

This one at least is already handled - ACPI ID tables are lists of IDs
just the same as everything else so we can have as many different
bindings for the same device as the hardware vendors see fit to bless us
with.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/33d8ac0c/attachment.sig>
