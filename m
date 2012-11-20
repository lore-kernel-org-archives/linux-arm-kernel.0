From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 20 Nov 2012 08:39:48 +0530
Subject: [PATCH 237/493] mmc: remove use of __devinit
In-Reply-To: <1353349642-3677-237-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-237-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAOh2x=mjF7fuptahGhSfbaonTMSDLg3VFYxxmG=K8yCbUcezuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:53 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: "Micha? Miros?aw" <mirq-linux@rere.qmqm.pl>
> Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: Bruce Chang <brucechang@via.com.tw>
> Cc: Harald Welte <HaraldWelte@viatech.com>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: linux-mmc at vger.kernel.org
> Cc: uclinux-dist-devel at blackfin.uclinux.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: spear-devel at list.st.com
> ---
>  drivers/mmc/host/sdhci-spear.c     |  8 +++-----

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
