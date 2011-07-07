From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 17:45:33 +0200
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <201107071745.33814.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Nicolas Pitre wrote:
> The boot_params member of the mdesc structure is used to provide a
> default physical address for the ATAG list.  Since this value is fixed
> at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
> of runtime PHYS_OFFSET usage.
> 
> Let's introduce atag_offset which should contains only the relative
> offset from start of memory instead of an absolute value, in preparation
> to move all instance of boot_params over to it.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

The series looks to me. Feel free to add my Acked-by everywhere
and/or push to a branch of the arm-soc tree when you're ready.

	Arnd
