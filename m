From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Jun 2018 12:49:08 -0300
Subject: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
In-Reply-To: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5Dnzk-pmFHNMXL8Zma_B2867F-tDgCO3A0uRqdbOPwUQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 3:32 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
