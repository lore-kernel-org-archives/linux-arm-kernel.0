From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2016 10:57:22 +0000
Subject: [PATCH 1/1] arm64: mm: add config options for page table
 configuration
In-Reply-To: <dd102973-5737-3168-bffe-7ac5e769aecb@broadcom.com>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
 <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
 <20161208100014.GE33075@MBP.local>
 <762b8bec-60da-0bb8-28f4-b407ad70687b@broadcom.com>
 <20161208185717.GC15141@e104818-lin.cambridge.arm.com>
 <dd102973-5737-3168-bffe-7ac5e769aecb@broadcom.com>
Message-ID: <20161209105722.GD11767@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 11:33:39AM -0800, Scott Branden wrote:
> Since I currently have your attention:  I do think there is fundamental bug
> in the ARM64 mm implementation.  If you look at /sys/devices/system/memory
> it only shows the last memoryX section created after init.

That directory doesn't seem to exist on my arm64 systems. Do I have to
enable something specific in the .config?

Will
