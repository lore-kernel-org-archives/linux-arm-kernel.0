From: npiggin@gmail.com (Nick Piggin)
Date: Tue, 25 Jan 2011 08:26:42 +1100
Subject: [PATCH v4 08/19] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <AANLkTi=d0q0Upde3=b4tpu3icOr4XdifcFRvBHuXgsBN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Too bad about the PAE thing; my condolences.


On Tue, Jan 25, 2011 at 4:55 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> This patch introduces the pgtable-3level*.h files with definitions
> specific to the LPAE page table format (3 levels of page tables).

Seeing as you're shaking up these definitions, what do you think about
switching from 4level-fixup.h to pgtable-nopud.h / pgtable-nopmd.h headers?
One day eventually it would be nice to get rid of the fixup mode.
