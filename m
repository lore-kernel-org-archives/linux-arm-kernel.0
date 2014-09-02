From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Sep 2014 09:42:14 +0100
Subject: [RESEND PATCH] arm64: dts: add <dt-bindings/> symlink
In-Reply-To: <1409629756-14304-1-git-send-email-pankaj.dubey@samsung.com>
References: <1409629756-14304-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140902084214.GE25379@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 04:49:16AM +0100, Pankaj Dubey wrote:
> Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/ to
> match the ones in ARM architectures so that preprocessed device
> tree files can include various useful constant definitions.
> 
> See commit c58299aa8754 ("kbuild: create an "include chroot" for DT bindings")
> merged in v3.10-rc1 for details.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> 
> Resubmitting this change as now it will be required for Samsung ARM64
> based SoC.

Just include this change in the series adding a .dts that needs it -- it
doesn't really make sense in isolation (unless somebody desperately wants
this in?).

Will
