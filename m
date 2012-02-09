From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 Feb 2012 17:14:07 -0800
Subject: [GIT PULL] mxs/clk for v3.4
In-Reply-To: <20120131154552.GG26436@S2101-09.ap.freescale.net>
References: <20120131154552.GG26436@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMhTTg88hUpG-5FYX5jT7JJG4be5B5-dS06oHVcJ-HMXCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 31, 2012 at 7:45 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Arnd, Olof,
>
> Please pull the following mxs clock changes for v3.4. ?It has no
> conflict with rmk/for-armsoc branch.
>
> Regards,
> Shawn
>
> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
>
> ?Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
>
> are available in the git repository at:
> ?git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/clk
>
> Fabio Estevam (1):
> ? ? ?ARM: mxs: Use a proper timeout mechanism
>
> Lothar Wa?mann (1):
> ? ? ?arm/mxs: Add support for SSP/MMC ports 2 & 3
>
> Wolfram Sang (1):
> ? ? ?ARM: mx28: check for gated clocks when setting saif divider


Pulled, thanks. Minor nit: in the future, please use the "ARM:
<platform>:" format consistently for patch prefixes.


-Olof
