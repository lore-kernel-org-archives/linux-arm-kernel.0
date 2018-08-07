From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 7 Aug 2018 12:54:29 +0530
Subject: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet
 support
In-Reply-To: <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
References: <20180807071839.25305-1-jagan@amarulasolutions.com>
 <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
Message-ID: <CAMty3ZDMw3OkZdGvt6tRY6KsSCNKcvptsty7n_t2s_mOzQnr5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2018?8?7? GMT+08:00 ??3:18:39, Jagan Teki <jagan@amarulasolutions.com> ??:
>>Add Ethernet support for orangepi-one-plus board,
>>- Ethernet port connected via RTL8211E PHY
>>- GMAC_EN is connected via PD6
>>- GMAC-3V supplied from ALDO2 regulator
>
> Is the prequisite patchset merged?

Not yet, I guess. Do you suggest to squash if not?
