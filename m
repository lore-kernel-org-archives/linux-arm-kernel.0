From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 22 Dec 2009 09:47:05 +0300
Subject: [PATCH 1/10] ARM: PNX4008: convert to clkdev
In-Reply-To: <083DF309106F364B939360100EC290F804F592E901@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F592E901@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <acd2a5930912212247j2c3c7d43s879f86da92c0f01@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:21 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>


> ---
>  arch/arm/Kconfig                            |    1 +
>  arch/arm/mach-pnx4008/clock.c               |   73
> +++++++++++++++------------
>  arch/arm/mach-pnx4008/clock.h               |    2 -
>  arch/arm/mach-pnx4008/include/mach/clkdev.h |    7 +++
>  4 files changed, 48 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091222/4a33722f/attachment-0001.htm>
