From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 Nov 2009 00:44:34 +0800
Subject: [PATCH] Convert viper to use plat_serial8250_port irqflags field
In-Reply-To: <20091114155314.59674efb@taxman.wild-wind.fr.eu.org>
References: <20091114155314.59674efb@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d70911160844s3e88ef1fo4c848cce0628f9d7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 10:53 PM, Marc Zyngier <maz@misterjones.org> wrote:
> Use .irqflags in the plat_serial8250_port structure to set IRQ
> polarity, and get rid of the corresponding set_irq_type().
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>

Applied to 'devel'. Thanks.
