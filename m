From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Mon, 9 Dec 2013 17:06:17 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core
 running without PCI on ARM64
In-Reply-To: <201312091735.05014.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <20131209115050.GA19163@arm.com> <52A5C024.5050702@linaro.org>
 <201312091735.05014.arnd@arndb.de>
Message-ID: <20131209170617.GC30717@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 05:35:04PM +0100, Arnd Bergmann wrote:

> Exactly. In particular we don't want people to get the wrong idea about
> where we are heading, so making it possible to use this code on embedded
> systems for me is a reason *not* to take the patch.

People are trying to deploy ACPI-based embedded x86, and most of the 
ACPI/DT integration discussion seems to have been based on the idea that 
this is a worthwhile thing to support. If we're not interested in doing 
so then we should probably make that a whole kernel decision rather than 
a per architecture one.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
