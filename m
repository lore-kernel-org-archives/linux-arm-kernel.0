From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Jul 2012 10:41:43 +0100
Subject: [RFC 01/23] ARM: LPAE: disable phys-to-virt patching on PAE
 systems
In-Reply-To: <1343092165-9470-2-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-2-git-send-email-cyril@ti.com>
Message-ID: <20120724094143.GB20132@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 02:09:03AM +0100, Cyril Chemparathy wrote:
> From: Vitaly Andrianov <vitalya@ti.com>
> 
> The current phys-to-virt patching mechanism is broken on PAE machines with
> 64-bit physical addressing.  This patch disables the patching mechanism in
> such configurations.

It may be broken, I don't remember whether I tested this feature. What's
the PHYS_OFFSET on your platform? Is it within the low 4GB range?

-- 
Catalin
