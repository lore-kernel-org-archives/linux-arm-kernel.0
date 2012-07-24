From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Jul 2012 10:49:10 +0100
Subject: [RFC 23/23] ARM: keystone: add switch over to high physical
 address range
In-Reply-To: <1343092165-9470-24-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-24-git-send-email-cyril@ti.com>
Message-ID: <20120724094910.GC20132@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 02:09:25AM +0100, Cyril Chemparathy wrote:
> Keystone platforms have their physical memory mapped at an address outside the
> 32-bit physical range.  A Keystone machine with 16G of RAM would find its
> memory at 0x0800000000 - 0x0bffffffff.

Ah, so the patches start to make sense now :). The PHYS_OFFSET is at
32G. I'll go back and look at the patches.

-- 
Catalin
