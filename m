From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 07 Aug 2014 15:14:44 +0200
Subject: [PATCH] ARM: imx6: add pci config space as platform resource
In-Reply-To: <CAOMZO5D4a5K4Pf-Z6sDjw2CuGsJ4-dLsVRtF_eh5cso_DVWoeA@mail.gmail.com>
References: <1407409120-23635-1-git-send-email-l.stach@pengutronix.de>
 <CAOMZO5Daf2+UcQKLkyiZeM7Zs9nd-ektO_f7n_3K-bw0GgPM8w@mail.gmail.com>
 <1407413960.4675.10.camel@weser.hi.pengutronix.de>
 <CAOMZO5D4a5K4Pf-Z6sDjw2CuGsJ4-dLsVRtF_eh5cso_DVWoeA@mail.gmail.com>
Message-ID: <1407417284.4675.11.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 07.08.2014, 09:29 -0300 schrieb Fabio Estevam:
> On Thu, Aug 7, 2014 at 9:19 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > The binding for this is part of the common designware binding. See
> > Documentation/devicetree/bindings/pci/designware-pcie.txt
> 
> The example section in imx6q-pcie.txt should be in sync with the pci
> node from imx6qdl.dtsi, right?
> 
Right, will fix this.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
