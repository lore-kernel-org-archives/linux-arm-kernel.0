From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2018 17:47:13 +0200
Subject: [PATCH] arm64: defconfig: Enable SERIAL_8250_OMAP
In-Reply-To: <20181005150440.6efkltod3nri6roy@kahuna>
References: <20181005100140.16716-1-lokeshvutla@ti.com>
 <20181005150440.6efkltod3nri6roy@kahuna>
Message-ID: <CAK8P3a1YRZUTx_NKdAROS5TiE1VfqmQAPY+rGexGN0Wq+v2Aww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 5:04 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 10:01-20181005, Lokesh Vutla wrote:
> > Enabling CONFIG_SERIAL_8250_OMAP that is used by TI's
> > AM6 SoC.
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > ---
> > - Based on next tag: next-20181005
> >
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Nishanth Menon <nm@ti.com>

Applied to next/defconfig, thanks!

       Arnd
