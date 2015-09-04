From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Sep 2015 12:26:32 +0100
Subject: [PATCH 2/3] arm64/setup: Use ID_AA64ISAR0_EL1_.* macros
In-Reply-To: <1441303972-9480-1-git-send-email-kuleshovmail@gmail.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
 <1441303972-9480-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <20150904112632.GC17253@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 12:12:52AM +0600, Alexander Kuleshov wrote:
> The 26d75e67c commit (arm64/cpufeature.h: Add macros for a cpu features

Please drop the commit number here, that's specific to your tree and not
something in mainline.

-- 
Catalin
