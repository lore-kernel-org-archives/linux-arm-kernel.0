From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 11:49:33 -0800
Subject: [PATCH v4 2/2] ARM: mach-moxart: add MOXA ART SoC device tree
 files
In-Reply-To: <1386945188-8316-3-git-send-email-jonas.jensen@gmail.com>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>
 <1386945188-8316-3-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131222194933.GE9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Fri, Dec 13, 2013 at 03:33:08PM +0100, Jonas Jensen wrote:
> Add a generic (dtsi) include file for MOXA ART SoCs.
> 
> Also add a file for UC-7112-LX.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied to next/dt. Again, please follow up with some of the comments -- in
particular the requests to keep the SoC IP blocks in the dtsi file and only
enable/disable or amend the entries in the per-board file depending on actual
board configuration. But I didn't see a reason to not merge it while that's
being cleaned up, etc.


-Olof
