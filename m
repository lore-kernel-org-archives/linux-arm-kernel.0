From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Thu, 4 Jun 2015 14:34:57 +0200
Subject: [PATCH linux-next 1/4] ARM: at91/dt: add new DT properties for
 Atmel usart
In-Reply-To: <6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
References: <cover.1433253787.git.cyrille.pitchen@atmel.com>
 <6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
Message-ID: <20150604143457.2a0e0acf@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Jun 2015 16:18:21 +0200, Cyrille Pitchen wrote:
> +- atmel,rts-low-threshold: when the RX FIFO level, ie the number of data
> +  available to be read from the RX FIFO, crosses down this threshold the RTS
> +  line is driven to low level to tell the remote peer that it can (re)start
> +  sending new data.
> +- atmel,rts-high-threshold: when the RX FIFO level crosses up this threshold,
> +  the RTS line is driven to high level to tell the remote peer that it should
> +  stop sending new data.

Maintainers, are there any guidelines for what is appropriate to put
into DT?  The parameters above look like they could be programmed at
runtime through some user space API like sysfs.
