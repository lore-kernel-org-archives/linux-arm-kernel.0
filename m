From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Thu, 10 Jun 2010 09:04:23 -0400
Subject: [PATCH] [kirkwood-otg] Leverage the Freescale OTG driver for
	Kirkwood OTG
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009F9FAC75ABB8@IL-MB01.marvell.com>
References: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
	<1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
	<alpine.LFD.2.00.1006091307321.30664@xanadu.home>
	<AANLkTikVeVBdSfeS_p0k4dRwFopELw2OIXUrS1NjEdt6@mail.gmail.com>
	<FCBE654890C0334289D0AD3AF4EF009F9FAC75ABB8@IL-MB01.marvell.com>
Message-ID: <AANLkTinIkve83opXyCMWuYP-4H2lf-DF5WnlzzA1qH3s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 6:57 AM, Saeed Bishara <saeed@marvell.com> wrote:
> Jason, the USB on kirkwood (and all orions) doesn't support OTG feature, it only support device mode when the system configured for that mode, so please repace the "otg" with udc.

Ack! Will do!


-- 
Jason S. McMullan
Netronome Systems, Inc.
