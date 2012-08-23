From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 08:48:51 +0000
Subject: [PATCH v2 0/3] ARM: PRIMA2: some patches prepared to support new
 SiRF SoCs
In-Reply-To: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
References: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201208230848.51650.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Barry Song wrote:
> we will support SiRFmarco and SiRFpolo SMP SoCs, this series is making
> mach-prima2 common for all of them.
> 
> Barry Song (3):
>   ARM: PRIMA2: use DT_MACHINE_START and convert to generic board
>   ARM: PRIMA2: adjust Kconfig to support select SoC features
>   ARM: SIRF: make sirf irqchip driver optional since new SoCs will have
>     GIC

Looks all good. Are you planning to send a git pull request, or should
we apply the patches from email?

	Arnd
