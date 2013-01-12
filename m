From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Jan 2013 17:44:55 -0700
Subject: [PATCH] arm: tegra: remove USB address related macros from iomap.h
In-Reply-To: <1355805061-22789-1-git-send-email-vbyravarasu@nvidia.com>
References: <1355805061-22789-1-git-send-email-vbyravarasu@nvidia.com>
Message-ID: <50F0B207.8000205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 09:31 PM, Venu Byravarasu wrote:
> USB register base address and sizes defined in iomap.h
> are not used in any files other than board-dt-tegra20.c.
> Hence removed those defines from header file and using
> the absolute values in board files.

Thanks, applied to Tegra's for-3.9/usb branch.
