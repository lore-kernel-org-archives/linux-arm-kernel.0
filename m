From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 May 2017 18:01:10 +0100
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
Message-ID: <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:31:25AM -0500, Timur Tabi wrote:
> Any changes to arch/arm64/configs/defconfig must be sent to arm at kernel.org,
> otherwise they will not get picked up.  Add a MAINTAINERS entry to ensure
> the get_maintainers includes it.

There are other patches that go through arm at kernel.org like
arch/arm64/boot/dts/ but the arm-soc guys didn't want a MAINTAINERS
entry (I don't remember the reasons).

-- 
Catalin
