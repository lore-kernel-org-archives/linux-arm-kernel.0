From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:54:52 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable cgroups
In-Reply-To: <1416254107-29326-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1416254107-29326-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <201411201354.52679.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014, Soren Brinkmann wrote:
> This allows booting the kernel with systemd-based root file systems.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> Hi,
> 
> I don't know whether I'm the only one, but I use a initramfs with
> systemd as init, which requires cgroup support in the kernel to fully
> boot.
> 

You probably are at this time, but I expect it to get more common
in the future, I don't think enabling this is controversial at all.

Applied to next/defconfig, thanks!

	Arnd
