From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2016 19:51:13 -0300
Subject: [PATCH v2 2/2] ARM: dts: utilite-pro: add mmc card slot support
In-Reply-To: <e008cb7118a345b0bea619e26731296b@rwthex-s1-b.rwth-ad.de>
References: <20160612151922.7600-1-christopher.spinrath@rwth-aachen.de>
 <e008cb7118a345b0bea619e26731296b@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5Cz9hZipK7cxerDqcUG25C1opdh3JuHCWCfBhC22nqQ1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 12:19 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>
> The Utilite Pro has a mmc card slot connected to the usdhc3
> controller. There is no card detection until hardware revision 1.3.
>
> Add support for it and signal the controller with the broken-cd
> property that polling has to be used to detect a card.
>
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
