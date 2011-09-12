From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Sep 2011 17:15:36 +0200
Subject: [GIT PULL] CSR prima2 changes for next
In-Reply-To: <CAGsJ_4xv3eeZtp_GEnifk3MpF=gaNRe=wVzLiojo=Jgy4qRePA@mail.gmail.com>
References: <CAGsJ_4xv3eeZtp_GEnifk3MpF=gaNRe=wVzLiojo=Jgy4qRePA@mail.gmail.com>
Message-ID: <201109121715.37886.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 September 2011, Barry Song wrote:
> Hi Arnd,
> can you please pull the 1st patchset of CSR prima2 for next? most of
> them are minor changes except that rtciobrg is new stuff.
> 
> The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
>   Linus Torvalds (1):
>         Linux 3.1-rc5
> 
> are available in the git repository at:
> 
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd
> 
> Barry Song (3):
>       ARM: CSR: add lost Resource Sharing Control(RSC) node in dts
>       ARM: CSR: extend the compatibility of gpio controller to pinmux in dts
>       ARM: CSR: IRQ: add simple irq_domain so that hw irq can map to Linux
> 
> Jamie Iles (1):
>       ARM: CSR: add missing sentinels to of_device_id tables
> 
> Zhiwu Song (1):
>       ARM: CSR: add rtc i/o bridge interface for SiRFprimaII
> 

Ok, pulled into the new arm-soc.git mirror on git.linaro.org.

I have taken the patch from Jamie into the 'fixes' branch and will submit
that for 3.1 unless there are complaints. The other patches are now in the
'next/devel' branch and queued for 3.2.

Please try to categorize your patches (bug fixes, general enhancements,
cleanups, new features, ...) in the future so I can directly pull
into the respective branches.

Thanks,

	Arnd
