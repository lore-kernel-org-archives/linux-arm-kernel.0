From: carlo@caione.org (Carlo Caione)
Date: Tue, 25 Mar 2014 22:27:35 +0100
Subject: [PATCH v7 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI
 controller
In-Reply-To: <1395256879-8475-1-git-send-email-carlo@caione.org>
Message-ID: <20140325212735.GA4853@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:21:16PM +0100, Carlo Caione wrote:
> Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
> Three register are present to (un)mask, control and acknowledge NMI.
> These two patches add a new irqchip driver in cascade with GIC.

Hi Thomas,
Is this ok with the Maxime ACKs?

-- 
Carlo Caione
