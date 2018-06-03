From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 17:57:41 -0300
Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
In-Reply-To: <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BZB_t5VYt3aGtjNuyFCwNK6KYnf9=4BN3Pd5oqYr58LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 2, 2018 at 10:44 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
