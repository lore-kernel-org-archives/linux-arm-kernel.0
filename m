From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jul 2015 13:18:04 -0300
Subject: [PATCH v2] ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <20150713152517.GE26642@tiger>
References: <1436796692-8875-1-git-send-email-fabio.estevam@freescale.com>
 <20150713152517.GE26642@tiger>
Message-ID: <CAOMZO5DsTQFjNJ+d8itOHR2HseyqFghnTWVE3K9LH2+vJqc+eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 12:25 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> There is already an assigned-clocks in &clks added by audio support.

Ops, that's true. Please consider v4 instead, which I have just tested
on the sabreauto board.
