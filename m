From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 May 2017 18:14:02 +0100
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
 <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
 <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
Message-ID: <20170503171401.GC23620@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 12:08:21PM -0500, Timur Tabi wrote:
> On 05/03/2017 12:01 PM, Catalin Marinas wrote:
> > On Wed, May 03, 2017 at 11:31:25AM -0500, Timur Tabi wrote:
> >> > Any changes to arch/arm64/configs/defconfig must be sent to arm at kernel.org,
> >> > otherwise they will not get picked up.  Add a MAINTAINERS entry to ensure
> >> > the get_maintainers includes it.
> > There are other patches that go through arm at kernel.org like
> > arch/arm64/boot/dts/ but the arm-soc guys didn't want a MAINTAINERS
> > entry (I don't remember the reasons).
> 
> I'm happy to add additional paths/files, but without a MAINTAINERS entry,
> how would anyone know to CC: that address?  I posted 3 versions of my
> defconfig patchset before someone told me that I had to send it to
> arm at kernel.org.

Most of the time it's the arm-soc guys pushing changes to defconfig,
though on occasion the arm64 maintainers make some changes as well.

> Anyway, I really hope it's not too late for my defconfig changes to make
> 4.12.  Please consider them.  Thank you.

I'm usually fine with such updates immediately after -rc1 but I can't
speak for the arm-soc folk.

-- 
Catalin
