From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Feb 2012 10:18:06 -0200
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120213082741.GN3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
Message-ID: <CAOMZO5AeagyOjcn_YQ1yRnKaapVvXSmjd5CmMm2ppGg6sTc8gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 2/13/12, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I really don't want to have that much code for saying 'we don't have a
> regulator, just make this stupid driver happy'. This is fine for one
> board, but not for the more than a dozen users of this driver in the tree.
> We should really add a helper to simplify this.

Will you consider applying this patch to fix 3ds_debugboard at least?

It is too bad to lose Ethernet on mx31pdk.

As far as the other users of the smsx911x driver in the tree, I have
no way to know whether each board does use a regulator or not, so that
their code can be fixed properly.

Regards,

Fabio Estevam
