From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 14 Mar 2015 11:00:43 +0000
Subject: [PATCH v2] efi/arm64: use UEFI for system reset and poweroff
In-Reply-To: <20150310144857.GE17573@codeblueprint.co.uk>
References: <1425653364-12591-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150310144857.GE17573@codeblueprint.co.uk>
Message-ID: <20150314110043.GA9696@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 02:48:57PM +0000, Matt Fleming wrote:
> On Fri, 06 Mar, at 03:49:24PM, Ard Biesheuvel wrote:
> > If UEFI Runtime Services are available, they are preferred over direct
> > PSCI calls or other methods to reset the system.
> > 
> > For the reset case, we need to hook into machine_restart(), as the
> > arm_pm_restart function pointer may be overwritten by modules.
> > 
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/efi.c     | 9 +++++++++
> >  arch/arm64/kernel/process.c | 8 ++++++++
> >  2 files changed, 17 insertions(+)
> 
> Looks good to me.
> 
> Reviewed-by: Matt Fleming <matt.fleming@intel.com>
> 
> Catalin, are you picking this up?

Yes, I will. Thanks.

-- 
Catalin
