From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 May 2018 08:26:14 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul: add GPIO clocks
In-Reply-To: <1526959560-6014-2-git-send-email-Anson.Huang@nxp.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1526959560-6014-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5AenOJ7vvxwsEp7FkTKEgjjZqvnHZRsU2MC=oZhk4J01Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 12:26 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
