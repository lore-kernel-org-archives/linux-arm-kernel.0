From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Tue, 31 Oct 2017 16:11:18 -0200
Subject: [PATCH v2] ARM: dts: imx7d-pico: Add Wifi support
In-Reply-To: <1503056221-29183-1-git-send-email-vanessa.maegima@nxp.com>
References: <1503056221-29183-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <CAP9ODKrp1+-u+OvuXLv_k7rpo-5Y6DpoxHFA+2zXM=XbPA7GBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 8:37 AM, Vanessa Maegima
<vanessa.maegima@nxp.com> wrote:
> imx7d-pico has an ap6212 wifi chip connected to usdhc2 port.
>
> Add support for the usdhc2 port and to the WL_REG_ON regulator
> so Wifi can be functional on this board.
>
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>

It seems the name of the dtb is misleading ... this dtb refers mostly
to the imx7d-pico-pi board no?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
