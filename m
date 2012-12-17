From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Dec 2012 13:12:22 -0200
Subject: [PATCH] ARM: mx27: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1354125330-18872-1-git-send-email-festevam@gmail.com>
References: <1354125330-18872-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5DZv3Xi-0hHpW=eU1GHZgEsNcsDzJh9Y+=-McbN7Vb=Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Nov 28, 2012 at 3:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Does this one look good?
