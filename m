From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 2 Jun 2016 15:36:50 +0100
Subject: [PATCH 1/3] efi: Introduce *_continue efi_memory_desc iterators
In-Reply-To: <20160601104326.GA24749@e104818-lin.cambridge.arm.com>
References: <1464707672-21882-1-git-send-email-catalin.marinas@arm.com>
 <1464707672-21882-2-git-send-email-catalin.marinas@arm.com>
 <20160601103446.GC9280@leverpostej>
 <20160601104326.GA24749@e104818-lin.cambridge.arm.com>
Message-ID: <20160602143650.GG2658@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Jun, at 11:43:26AM, Catalin Marinas wrote:
> 
> Thanks for the heads up. I'll rebase the patches after -rc2 but anyway I
> plan to merge them in 4.8 via the arm64 tree, including the patch above
> if Matt acks it. So there is enough time to fix the conflicts.

I'd really prefer it if you didn't take this series through the arm64
tree, unless there are existing dependencies, of course.

There were a number of conflicts in 3 different maintainer trees in
linux-next before the most recent merge window opened, and extra work
was required to sort that out. I want to avoid that in the future, so
expect me to be more insistent about keeping EFI patches in the EFI
tree than I have been in the past. 

Do arm64 prerequisites exist for this series? Or are you planning on
adding dependencies on top?
