From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Feb 2018 13:43:55 -0200
Subject: [PATCH v2 2/2] arm64: dts: fsl: imx8mq-evk: enable watchdog
In-Reply-To: <ae093f95bae9f4f92c5bbc6fc06cdeb8cfc1d1e1.1518016370.git.baruch@tkos.co.il>
References: <57855fb372ae19aad54c39c0e18a54cb12ed6915.1518016370.git.baruch@tkos.co.il>
 <ae093f95bae9f4f92c5bbc6fc06cdeb8cfc1d1e1.1518016370.git.baruch@tkos.co.il>
Message-ID: <CAOMZO5COoQTo1Lp_B3CFroepnS_CRRtVSUqOenPpqkumfk85SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 7, 2018 at 1:12 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> The external nWDOG signal connects to the EVK board reset circuit.
>
> Tested on the i.MX8MQ EVK rev B3.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

There is an ongoing discussion whether we are going to adopt this
generic pinctrl scheme or the old i.MX pinctrl scheme on i.MX8MQ.

Anyway this patch looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
