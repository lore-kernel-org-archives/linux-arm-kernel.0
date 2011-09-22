From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Sep 2011 17:13:27 +0200
Subject: [GIT PULL] CSR prima2 PM support for 3.2
In-Reply-To: <CAGsJ_4y6vuy8ZicefRR8DE6Zoj2nzy1JcOxhHK3Xos8d9NxxSQ@mail.gmail.com>
References: <CAGsJ_4y6vuy8ZicefRR8DE6Zoj2nzy1JcOxhHK3Xos8d9NxxSQ@mail.gmail.com>
Message-ID: <201109221713.27370.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 September 2011, Barry Song wrote:
> Hi Arnd,
> 
> Can you pls pull the prima2 PM support for 3.2? As the patchset
> depends on rtciobrg you pulled last time, i didn't rebase it to 3.1-rc
> to avoid merge conflict.
> 
> The following changes since commit 684f741446f7a3108b4c167faf20214c42b7eeac:
>   Zhiwu Song (1):
>         ARM: CSR: add rtc i/o bridge interface for SiRFprimaII
> 
> are available in the git repository at:
> 
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd
> 
> Barry Song (2):
>       ARM: CSR: PM: save/restore timer status in suspend cycle
>       ARM: CSR: PM: save/restore irq status in suspend cycle
> 
> Rongjun Ying (1):
>       ARM: CSR: PM: add sleep entry for SiRFprimaII

Pulled, thanks!

	Arnd
