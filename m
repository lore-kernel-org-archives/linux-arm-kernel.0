From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 07 Feb 2018 16:49:08 +0100
Subject: [PATCH v2 2/2] arm64: dts: fsl: imx8mq-evk: enable watchdog
In-Reply-To: <CAOMZO5COoQTo1Lp_B3CFroepnS_CRRtVSUqOenPpqkumfk85SQ@mail.gmail.com>
References: <57855fb372ae19aad54c39c0e18a54cb12ed6915.1518016370.git.baruch@tkos.co.il>
 <ae093f95bae9f4f92c5bbc6fc06cdeb8cfc1d1e1.1518016370.git.baruch@tkos.co.il>
 <CAOMZO5COoQTo1Lp_B3CFroepnS_CRRtVSUqOenPpqkumfk85SQ@mail.gmail.com>
Message-ID: <1518018548.3175.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 07.02.2018, 13:43 -0200 schrieb Fabio Estevam:
> On Wed, Feb 7, 2018 at 1:12 PM, Baruch Siach <baruch@tkos.co.il>
> wrote:
> > The external nWDOG signal connects to the EVK board reset circuit.
> > 
> > Tested on the i.MX8MQ EVK rev B3.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> There is an ongoing discussion whether we are going to adopt this
> generic pinctrl scheme or the old i.MX pinctrl scheme on i.MX8MQ.

Yep, ignoring this discussion, patch looks good. I've just tested this
on my MX8_EVK A1 board and it seems to work fine.

Tested-by: Lucas Stach <l.stach@pengutronix.de>
