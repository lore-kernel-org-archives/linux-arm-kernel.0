From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Jan 2015 14:56:02 +0100
Subject: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
In-Reply-To: <54BD0A49.8030107@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <5407007.ZAjCvvOzus@wuerfel> <54BD0A49.8030107@arm.com>
Message-ID: <45882386.HAzdnpUX2E@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 January 2015 13:44:41 Andre Przywara wrote:
> 
> > Would we be better off documenting that 8-n-1 is the only allowed settting?
> > I can't think of a reason why anyone would use something else.
> 
> Reading the spec again I see that 8-bit word len is mandated:
> "The generic UART uses 8-bit words, equivalent to UARTLCR_H.WLEN == b11."
> So given this I guess anything other than (8)n1 is pretty useless and
> wouldn't probably be used anyways. This means that we can get rid of the
> optional properties altogether and just add "current-speed" to the list
> of required ones. I am about to implement this.

Ok, great!

	Arnd
