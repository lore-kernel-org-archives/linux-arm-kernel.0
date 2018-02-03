From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 2 Feb 2018 22:02:22 -0200
Subject: [PATCH v3 2/3] ARM: dts: imx: Remove empty memory size nodes
In-Reply-To: <1516800134-5018-2-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
 <1516800134-5018-2-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5DtiRgkYkkjv4hmt-1QFD3Ys0rzjcUFGxBXPYM-trOoAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:22 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> Remove the empty reg property from the SoC dtsi files in order to avoid
> duplicate memory nodes when the correct size is passed in board dts files.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
