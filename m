From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Jun 2014 11:35:32 +0200
Subject: [PATCH 0/5] ARM: Berlin: SMP support
In-Reply-To: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140602093532.GF28090@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 11:21:01AM +0200, Antoine T?nart wrote:
> This series adds the SMP support for Marvell Berlin BG2 and BG2Q.
> 
> This implementation takes advantage of the reset exception register and
> the software reset address register to make the CPUs execute the Berlin
> secondary startup when being being reseted. This has the advantage of

Hi Antoine.

One of these funny rules of English is that there is no word
'reseted'. It is just 'reset'. Also, one 'being' is enough!

	   Andrew
