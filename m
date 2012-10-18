From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Oct 2012 16:52:46 -0700
Subject: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
In-Reply-To: <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
 <20121016172258.GT15569@atomide.com>
 <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
Message-ID: <20121018235246.GK30550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar,

* Omar Ramirez Luna <omar.luna@linaro.org> [121017 16:54]:
> On 16 October 2012 12:22, Tony Lindgren <tony@atomide.com> wrote:
>
> > These will need to be rebased on omap-for-v3.8/cleanup-headers-iommu
> > when I have that pushed out as that removes plat/*iommu*.h files.
> 
> Ok, will wait and rebase on top of it.

Thanks, the related patches are now posted in thread
"[PATCH v3 0/6] omap iommu changes to remove plat includes".

Also, can you please take a look at the "Updated status of the removal
of plat headers" thread?

I've tagged you to remove the omap plat/mailbox.h :) 

Regards,

Tony
