From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Aug 2016 14:03:45 -0300
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for cortex-a7
 single core
In-Reply-To: <57B343E4.6090604@arm.com>
References: <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej> <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej> <20160808145916.0924e868@arm.com>
 <20160809034613.GB31105@shlinux2> <20160809063401.3117dc94@arm.com>
 <20160809055701.GC31105@shlinux2> <20160809075930.529f98ca@arm.com>
 <20160809071821.GD31105@shlinux2> <57A99A4A.6010301@arm.com>
 <CAOMZO5AB1u3+pL1kgxwF1zNH5MSxEd-BrT=3dzwUTxBd0R4Vsw@mail.gmail.com>
 <57B343E4.6090604@arm.com>
Message-ID: <CAOMZO5Abm-cpm=R6+JLoA+5QDCkgF84Db3uLhNrpe4KM5btu1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Aug 16, 2016 at 1:48 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Maybe because you now have a pending interrupt that you don't handle,
> making your WFI exit immediately? Sorry, but without more information,
> it is pretty hard to guess what's happening.

Tested the same kernel on a imx6ul-evk and 'reboot' and suspend/resume
work fine.

Looks like the issue I saw is imx6ul-pico board specific.

Thanks
