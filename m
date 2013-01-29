From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 16:08:59 +0000
Subject: [PATCH] serial: pl010/pl011: move clk_enable from console
 write to setup
In-Reply-To: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
References: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
Message-ID: <20130129160859.GD23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 12:05:26AM +0800, Liming Wang wrote:
> There seems no need to call clk_enable in every console writing. And we
> can move clk_enable to setup function to enable the clock only once.
> Also combine the clk_enable and clk_prepare to clk_prepare_enable.

NAK.  Just Nak.
