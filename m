From: carlo.caione@gmail.com (Carlo Caione)
Date: Mon, 13 Jan 2014 20:01:59 +0100
Subject: [PATCH v3 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI
In-Reply-To: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <CAOQ7t2ZqnTwJ-ws2OEYEOS1L5_BeW24_CYoJPsRLF9+pVV7pkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 4:19 PM, Carlo Caione <carlo.caione@gmail.com> wrote:
> Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
> Three register are present to (un)mask, control and acknowledge NMI.
> These two patches add a new irqchip driver in cascade with GIC.
>
> Changes since v1:
>         - added binding document
>
> Changes since v2:
>         - fixed trigger type in DTS
>         - new explanations in binding documentation
>         - added support for A31 (sun6i)

Ping
