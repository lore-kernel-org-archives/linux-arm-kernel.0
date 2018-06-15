From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2018 16:47:48 -0300
Subject: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
In-Reply-To: <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The FBDEV driver uses the same name and both can't be registered at the
> same time. Fix this by renaming the drm driver to mxsfb-drm
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Stefan sent the same patch a few days ago:
https://www.spinics.net/lists/dri-devel/msg179489.html
