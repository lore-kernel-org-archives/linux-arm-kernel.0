From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Aug 2016 10:05:05 -0300
Subject: [PATCH v2] ARM: dts: imx6ul-pico-hobbit: Add Wifi support
In-Reply-To: <1470056054-5133-1-git-send-email-vanessa.maegima@nxp.com>
References: <1470056054-5133-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <CAOMZO5BTrefgLfmqNKHg5BoLnsOvtGxAkAwgMX7EvkQpgSFubQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vanessa,

On Mon, Aug 1, 2016 at 9:54 AM, Vanessa Maegima <vanessa.maegima@nxp.com> wrote:
> imx6ul-pico-hobbit has a bcm4339 wifi chip connected to usdhc2 port.
>
> Add support for the WL_REG_ON regulator, so that Wifi can be functional
> on this board.
>
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>

With this patch applied I was able to successfully use Wifi on this board:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks
