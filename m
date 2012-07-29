From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jul 2012 16:07:56 -0700
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50130F36.4090902@gmail.com>
References: <50049285.1060100@gmail.com>
	<50130F36.4090902@gmail.com>
Message-ID: <CAOesGMiWuqqprQ8GGzAgpFNE7k=qvPJpsx7MiVv2CKsSqyiQiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 27, 2012 at 2:59 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 07/16/2012 05:15 PM, Rob Herring wrote:
>> Arnd,
>>
>> Please pull io.h PCI clean-up series. As you suggested, lets get it in
>> next for test and decide later if to apply it for 3.6 or wait.
>>
>> BTW, I'll have sporadic email access over the next 2 weeks.
>>
>> Rob
>>
>
> Arnd,
>
> Please pull updated io.h cleanup for PCI branch. I rebased this as the
> changes shifted things around a bit. This has the following changes:
>
> - Incorporated fixes from you and Stephen
> - Add early i/o mapping pci_map_io_early and enable on footbridge and
> integrator for VGA console
> - Avoid including map.h in asm/mach/pci.h which collided with EDAC.
>
> Rob
>
> The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:
>
>   Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)
>
> are available in the git repository at:
>
>   git://sources.calxeda.com/kernel/linux.git io-cleanup-pci-v2

I have replaced the current staging/io-cleanup-pci contents with the
above branch. Ideally I'd like to see a fix to the issues on
integrator before we send it up though.


-Olof
