From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 13:11:53 +0000
Subject: [PATCH v2 10/20] ARM: LPAE: Remove the FIRST_USER_PGD_NR and
	USER_PTRS_PER_PGD definitions
In-Reply-To: <1289584840-18097-11-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-11-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101122131153.GF31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:30PM +0000, Catalin Marinas wrote:
> These macros were only used in setup_mm_for_reboot and get_pgd_slow.
> Both have been modified to no longer use these definitions. One of the
> reasons is the different meaning that PGD has with the 2-level and
> 3-level page tables.

We don't actually need this macro anymore, it can be killed (and I've
already done so.)
