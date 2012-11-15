From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Nov 2012 11:38:01 -0200
Subject: [PATCH v2 1/2] ARM: mx27: Add VPU support
In-Reply-To: <20121115081223.GY10369@pengutronix.de>
References: <1352917238-29694-1-git-send-email-fabio.estevam@freescale.com>
 <20121115081223.GY10369@pengutronix.de>
Message-ID: <CAOMZO5BrzD5okmRMcY3X3aquMpmxV5Pn2k2upsQNhsmq_Pi5-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 6:12 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> As Eric mentioned this may lead to problems on the i.MX27L without VPU.
> Do you have the possibility to test this?

I do not have any board with a MX27L variant. Maybe we could try
reading the SREV info register to distinguish between MX27 and MX27L.
MX27RM does not provide any info on this though.

If this does not work, then maybe we should register VPU as per board
like the v1 patch did.

Regards,

Fabio Estevam
