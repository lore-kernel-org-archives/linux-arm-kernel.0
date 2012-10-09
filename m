From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Oct 2012 21:11:18 +0800
Subject: [PATCH v2] ARM: mxs_defconfig: Improve USB related support
In-Reply-To: <1349630183-29297-1-git-send-email-festevam@gmail.com>
References: <1349630183-29297-1-git-send-email-festevam@gmail.com>
Message-ID: <20121009131113.GF21822@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 02:16:23PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Select the following USB related options:
> 
> - USB Ethernet adapter (needed for mx23-olinuxino)
> - Native language support (needed for mounting USB pen drives, for example)
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued for 3.8.

Per request from arm-soc folks, we will need to squash defconfig
changes into 1~2 patches before sending them to arm-soc.

Shawn
