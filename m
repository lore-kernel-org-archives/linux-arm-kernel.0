From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jul 2016 09:29:17 -0300
Subject: [PATCH] ARM: mxs: remove obsolete startup code for TX28
In-Reply-To: <1468239528-10501-1-git-send-email-LW@KARO-electronics.de>
References: <1468239528-10501-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <CAOMZO5DOChijh+kSV2Z0A1UVdyecyvPNFzuMdJ-btnx4RtsOTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 9:18 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> The power and reset handling of the FEC ethernet driver is sufficient
> to get the ethernet PHY on the TX28 into a usable state.
> Remove the code that does the PHY initialization on startup.
>
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Nice cleanup!

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
