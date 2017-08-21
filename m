From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 21 Aug 2017 13:21:24 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170808133411.opuh7pz3kmlhkhzy@armageddon.cambridge.arm.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
 <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
 <20170707171135.h54fe4ea7xuxnrqt@armageddon.cambridge.arm.com>
 <20170724112624.7ie6na7uszmsc5te@yury-thinkpad>
 <20170808133411.opuh7pz3kmlhkhzy@armageddon.cambridge.arm.com>
Message-ID: <20170821102124.xcqnzdzhs73gzbcf@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 02:34:11PM +0100, Catalin Marinas wrote:
> On Mon, Jul 24, 2017 at 02:26:24PM +0300, Yury Norov wrote:
> > This is the 4.12 and linux-next - based kernel patches:
> > https://github.com/norov/linux/tree/ilp32-4.12
> > https://github.com/norov/linux/tree/ilp32-20170724
> 
> I published the 4.12 branch here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=staging/ilp32-4.12
> 
> (or git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git staging/ilp32-4.12)
> 
> There are two patches on top, one to fix SET_PERSONALITY and the other
> to make ILP32 default y since you'd expect people using this branch to
> need such option enabled.
> 
> I'll publish a 4.13-based branch when the corresponding kernel version
> is released.

Hi Catalin,

This is the rc-6 based ilp32 series:
https://github.com/norov/linux/tree/ilp32-4.13-rc6

It includes latest version of SET_PERSONALITY() rework:
https://www.spinics.net/lists/arm-kernel/msg602005.html

All patches prior to 3fc85ee96eb8 ("arm64: ilp32: add documentation on
the ILP32 ABI for ARM64") are looking not ilp32-specific and may be
applied independently.

It also includes your patch "arm64: ilp32: Make the Kconfig option
default y" on the top of series.

Yury
