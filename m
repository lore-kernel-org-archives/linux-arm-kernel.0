From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 14:35:10 +0100
Subject: [PATCH v2 1/4] irqchip: add basic infrastructure
In-Reply-To: <508D3359.6000309@gmail.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351416634-3352-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <508D30B2.6070806@gmail.com> <20121028142408.7512671c@skate>
 <508D3359.6000309@gmail.com>
Message-ID: <20121028143510.6d880b58@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Sun, 28 Oct 2012 08:30:01 -0500, Rob Herring wrote:

> It will give a kconfig error rather than build error on of_irq_init
> which would result in patches for empty of_irq_init.

Right.

> How about default y and depends on OF_IRQ. Then you don't need a select.
> I think we want all DT enabled platforms to use this and it's only a
> small amount of init space.

Sounds good. Will do and post a v3.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
