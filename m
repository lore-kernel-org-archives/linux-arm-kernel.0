From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 07:23:48 -0300
Subject: [PATCH] ARM: dts: imx6sll: declare src module to be compatible to
 imx51's src
In-Reply-To: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
References: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DdLzEVqDLwk-+JGt0RCLM=VgOYwmH8GZmVzgu_Sw8MhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 5:38 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
> compatible string to enable SRC driver to support setting
> CPU resume address for cpu-idle and suspend/resume.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
