From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:05 +0100
Subject: [PATCH 0/5] Adding x86-like memory map printks to ARM.
In-Reply-To: <20090810213905.GA4046@n2100.arm.linux.org.uk>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
Message-ID: <1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version has the following changes:

* Reworked UL() macro usage, as suggested

* Appended 'UL' to VMALLOC_END define of new machines:
mach-dove
mach-u300
mach-ux500

* Patch 'Make totalhigh_pages unsigned long' has been submitted separately

* Removed superfluous (VMALLOC_START < VMALLOC_END) boundary check
