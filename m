From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 17 Sep 2013 22:36:51 -0500
Subject: [PATCH 20/28] arm64: set initrd_start/initrd_end for fdt scan
In-Reply-To: <8639E68F-4CCB-4E34-82BF-18EDA98BB978@arm.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
 <1379372965-22359-21-git-send-email-robherring2@gmail.com>
 <8639E68F-4CCB-4E34-82BF-18EDA98BB978@arm.com>
Message-ID: <20130918033651.3FA9AC42CA8@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Sep 2013 09:50:04 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 17 Sep 2013, at 00:09, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > In order to unify the initrd scanning for DT across architectures, make
> > arm64 use initrd_start and initrd_end instead of the physical addresses.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
