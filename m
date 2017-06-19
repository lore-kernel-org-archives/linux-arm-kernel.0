From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 19 Jun 2017 16:02:29 +0200
Subject: [PATCH v5 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <CAOMZO5Dd243VXCYBigTcFJ2aF4prZhWYtOuw7Z86M4X6nEXB=A@mail.gmail.com>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-2-o.rempel@pengutronix.de>
 <8e50ff3d-d1f0-2795-5dc9-302979ca9694@i2se.com>
 <20170619060629.du3qmihhkkyym44h@pengutronix.de>
 <b8d7d65c-93c8-8b62-abb4-09d60c32bf84@i2se.com>
 <CAOMZO5Dd243VXCYBigTcFJ2aF4prZhWYtOuw7Z86M4X6nEXB=A@mail.gmail.com>
Message-ID: <f83cae78-4422-ce07-7a39-92ba70be8de6@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.06.2017 um 14:52 schrieb Fabio Estevam:
> Hi Stefan,
>
> On Mon, Jun 19, 2017 at 7:58 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>> do you know how the clock "lp_ipg_clk_s" should be handled?
> As per the Reference Manual there is no CCM gating bits for this clock.


I was only surprised that there is no clock handling in the driver.
Sorry, about that noise.
