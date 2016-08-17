From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Aug 2016 10:28:02 -0300
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
In-Reply-To: <57B45F47.7030801@arm.com>
References: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
 <CAL411-pUUdxN_d76FaXYGtEd7Seewnrin=x2mFEbi1Z48zSRvg@mail.gmail.com>
 <57B41523.6030202@arm.com>
 <VI1PR04MB1455E9F56D0EDA0558CC84508B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <57B41B90.3050204@arm.com>
 <VI1PR04MB14558618D41FFF0BA4616BD08B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <57B42C18.1090400@arm.com>
 <VI1PR04MB14552BEF9184FF2AE23A51B58B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <57B45F47.7030801@arm.com>
Message-ID: <CAOMZO5Dg4qpdxJzKhAJVy7Ttv6NEEKU_FFrmyTV3hKbxsiomZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Wed, Aug 17, 2016 at 9:57 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Look, we've been there before. For your platform to work with your
> configuration, you need the GIC patch that I already posted, and that
> has been tested by Fabio Estevam on the same A7 platform.

Yes, here is Marc's GIC patch that fixes the 'reboot' hang on mx6ul:
http://www.spinics.net/lists/arm-kernel/msg522576.html
