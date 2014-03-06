From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Mar 2014 15:01:30 +0100
Subject: [PATCH 2/2] imx-drm: imx-ldb: Use OF graph to find connected panel
In-Reply-To: <1394114080-27223-2-git-send-email-p.zabel@pengutronix.de>
References: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
 <1394114080-27223-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394114490.3622.15.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 06.03.2014, 14:54 +0100 schrieb Philipp Zabel:
> This patch depends on the OF graph parsing helper and imx-drm-dt series.
> It allows to connect the panel to the output port (port at 1 on i.MX53, port at 4
> on i.MX6) via the OF graph bindings.

If we postpone this until the imx-drm-dt binding series gets accepted, I
can just squash the two patches together.

regards
Philipp
