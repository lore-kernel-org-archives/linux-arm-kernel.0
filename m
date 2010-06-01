From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 1 Jun 2010 08:56:22 -0700 (PDT)
Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and
	registration
In-Reply-To: <1275405043-18230-4-git-send-email-jason77.wang@gmail.com>
Message-ID: <495250.54370.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

--- On Tue, 6/1/10, Jason Wang <jason77.wang@gmail.com> wrote:

> From: Jason Wang <jason77.wang@gmail.com>
> Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and registration
> To: s.hauer at pengutronix.de, amit.kucheria at canonical.com
> Cc: linux-arm-kernel at lists.infradead.org
> Date: Tuesday, June 1, 2010, 12:10 PM
> On i.MX51 platforms, the keypad
> controller has no gate clock, to
> meet the imx keypad driver requirement, we add a empty
> definition and
> register it. Now the keypad driver can work.

I did not see an entry for the keypad at arch/arm/mach-mx5/devices.c.

Regards,

Fabio Estevam


      
