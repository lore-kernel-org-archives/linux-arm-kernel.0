From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Dec 2016 16:07:59 +0100
Subject: [PATCH 1/4] net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to
 be used at address 0x1
In-Reply-To: <CABHmqqDqhJa6N=Ayu-GFNyp4g90dXzTje6o8qfCEP2DacCFWdQ@mail.gmail.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-2-romain.perier@free-electrons.com>
 <20161219143848.GA10048@lunn.ch>
 <292d4f15-c58b-3565-26ec-98a025b6adb3@free-electrons.com>
 <20161219150008.GE10048@lunn.ch>
 <CABHmqqDqhJa6N=Ayu-GFNyp4g90dXzTje6o8qfCEP2DacCFWdQ@mail.gmail.com>
Message-ID: <20161219150759.GG10048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 04:04:32PM +0100, Volodymyr Bendiuga wrote:
> Hi Andrew,
> 
> No, it did not get accepted. Or at least I did not see
> David accepting it. Let me know if I should resubmit it.

Hi Volodymyr

Please do resend it. Probably netdev will reopen sometime after the
25th.

Don't forget to include the reviewed-by i gave.

Thanks

	Andrew
