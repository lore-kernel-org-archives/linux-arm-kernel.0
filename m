From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 19 Jun 2017 09:52:06 -0300
Subject: [PATCH v5 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <b8d7d65c-93c8-8b62-abb4-09d60c32bf84@i2se.com>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-2-o.rempel@pengutronix.de>
 <8e50ff3d-d1f0-2795-5dc9-302979ca9694@i2se.com>
 <20170619060629.du3qmihhkkyym44h@pengutronix.de>
 <b8d7d65c-93c8-8b62-abb4-09d60c32bf84@i2se.com>
Message-ID: <CAOMZO5Dd243VXCYBigTcFJ2aF4prZhWYtOuw7Z86M4X6nEXB=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Jun 19, 2017 at 7:58 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> do you know how the clock "lp_ipg_clk_s" should be handled?

As per the Reference Manual there is no CCM gating bits for this clock.
