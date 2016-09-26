From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Sep 2016 11:08:20 -0300
Subject: [PATCH] serial: imx: Fix DCD reading
In-Reply-To: <20160926135531.31888-1-s.hauer@pengutronix.de>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5Cdime2w+R=UirP68ibKogYn2iuzGmuWt4yakQ+kmPDXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Sep 26, 2016 at 10:55 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The USR2_DCDIN bit is tested for in register usr1. As the name
> suggests the usr2 register should be used instead. This fixes
> reading the Carrier detect status.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Good catch:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Shouldn't this have stable on Cc?
