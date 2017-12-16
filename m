From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:03:49 -0200
Subject: [PATCH 7/9] ARM: dts: imx7-colibri: specify backlight GPIO
In-Reply-To: <20171206153005.6144-7-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-7-stefan@agner.ch>
Message-ID: <CAOMZO5BRpSBQ5Hu1Y9pLGLdm84FeyBnjyFsXC+1BdJXosR11Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:30 PM, Stefan Agner <stefan@agner.ch> wrote:
> The Colibri standard defines SODIMM 71 as backlight enable
> GPIO. Assign the GPIO to the backlight node in the module
> level device tree.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
