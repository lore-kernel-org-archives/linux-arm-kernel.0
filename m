From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:02:21 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.20
In-Reply-To: <20180929145659.73sto3j7235jg6b6@flea>
References: <20180929145659.73sto3j7235jg6b6@flea>
Message-ID: <CAK8P3a3qoz2rY2PLxBpLpr+7uFD9jwbWNAipD4RNC1bH9b9b_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 4:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> ----------------------------------------------------------------
> Allwinner arm64 DT changes for 4.20
>
> Our usual set of DT changes for the arm64 Allwinner SoCs.
>
> The most notable things are:
>   - HDMI support on the A64
>   - New boards: OrangePi One Plus

I just had a look at the OrangePi One Plus, that seems to be a particularly
nice combination of low price and (possibly) low power consumption with
the 28nm CPU and LPDDR3 memory. How well does it work in practice?

Pulled into next/dt, thanks!

       Arnd
