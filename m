From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 19 Mar 2014 12:13:56 +0100 (CET)
Subject: [PATCH v6 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for
 NMI controller
In-Reply-To: <1394890861-18347-1-git-send-email-carlo@caione.org>
References: <1394890861-18347-1-git-send-email-carlo@caione.org>
Message-ID: <alpine.DEB.2.02.1403191213240.18573@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 15 Mar 2014, Carlo Caione wrote:

> Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
> Three register are present to (un)mask, control and acknowledge NMI.
> These two patches add a new irqchip driver in cascade with GIC.

If I get an ack for the DT parts, I'll pick it up.
