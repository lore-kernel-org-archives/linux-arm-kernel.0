From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 18:24:24 +0000
Subject: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related
 stuff to make it more arch-independent
In-Reply-To: <3459962.GkY99aHQbc@vostro.rjw.lan>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
 <1392740638-2479-3-git-send-email-hanjun.guo@linaro.org>
 <3459962.GkY99aHQbc@vostro.rjw.lan>
Message-ID: <20140221182424.GA5751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Wed, Feb 19, 2014 at 01:50:22AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
> > _PDC related stuff in processor_core.c is little bit X86/IA64 dependent,
> > rework the code to make it more arch-independent, no functional change
> > in this patch.
> > 
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> 
> I've queued up patches [1,3-5/5] from this series for 3.15 (modulo changelog
> modifications), but this one should be CCed to the x86 and ia64 maintainers.

Thanks for taking these patches. I would however hold onto patch 3/5 as
this is still under discussion. Basically for patches specific to ARM
ACPI I would really like to see more acks before being merged as that's
a new thing for us.

Thanks.

-- 
Catalin
