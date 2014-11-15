From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Nov 2014 12:02:08 +0100
Subject: [PATCH v5 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <1416048391-7557-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1416048391-7557-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1482989.i0U06CvWpS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 November 2014 16:16:25 Bhupesh Sharma wrote:
> This patchset adds the support for FSL's LS2085A SoC which is based on
> ARMv8 architecture.
> 
> This patchset also has patches which address DT compatible strings for
> nodes which appear un-documented.
> 
> The enable-method for the CPU nodes is left for the bootloader (u-boot or UEFI)
> to patch-up which is expected to be PSCI v0.2
> 

Looks all good to me. Are you planning to send a pull request to
arm at kernel.org, or should we pick up the patches directly (provided
no more new review comments)?


	Arnd
