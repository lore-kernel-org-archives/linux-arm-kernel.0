From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 23:45:53 -0300
Subject: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Mon, Jun 24, 2013 at 2:24 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The ADCs connected to this bus have been experiencing some timeout
> issues when using the iMX28 i2c controller. Switching back to bitbanging
> solves this.

Are you able to use the mxs i2c controller instead of bitbang if you
use this patch?
http://www.spinics.net/lists/stable/msg13202.html

Regards,

Fabio Estevam
