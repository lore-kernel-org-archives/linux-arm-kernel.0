From: carlo.caione@gmail.com (Carlo Caione)
Date: Wed, 8 Jan 2014 11:41:23 +0100
Subject: [PATCH v2 0/3] ARM: sun7i: irqchip: Irqchip driver for NMI
In-Reply-To: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <CAOQ7t2YsFrMuzKPhggEHt1sinPL_NqvUm=fG9fjEK57qDCrM2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 6, 2014 at 6:41 PM, Carlo Caione <carlo.caione@gmail.com> wrote:
> Allwinner A20 SoCs have a special interrupt controller for managing NMI.
> Three register are present to (un)mask, control and acknowledge NMI.
> These two patches add a new irqchip driver in cascade with GIC.
>
> Changes since v1:
>         - added binding document

Ping?
