From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 09:47:14 +0100
Subject: [PATCH] Make SPARSE_IRQ a hidden option
In-Reply-To: <AANLkTimmwLIubkxfagve_QBfD9KahO57Q_-vwhV3h4VU@mail.gmail.com>
References: <AANLkTimmwLIubkxfagve_QBfD9KahO57Q_-vwhV3h4VU@mail.gmail.com>
Message-ID: <20100722084714.GL6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 10:43:07AM +0200, Eric Miao wrote:
>     [ARM] Make SPARSE_IRQ a hidden option
> 
>     SPARSE_IRQ doesn't need to be a visible option, only those platforms
>     supporting that will select it.

Ok.
