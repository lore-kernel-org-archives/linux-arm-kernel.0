From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Nov 2011 22:18:00 +0000
Subject: [PATCH v2 0/6] Consolidate identity mapping code in idmap.c
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <20111130221800.GV9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 06:28:51PM +0000, Will Deacon wrote:
> Hello,
> 
> This is version 2 of the patch series originally posted here:
> 
>  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073033.html
> 
> Changes from v1 include:
> 	* Updated following Catalin's comments
> 	* Rebased onto rmk/devel-stable
> 	* Includes update to SMP booting so that the idmap_pgd can be
> 	  used there too
> 
> This is a pre-requisite for my kexec patches, which I will post separately.
> 
> All feedback welcome.

This patch set looks fine.
