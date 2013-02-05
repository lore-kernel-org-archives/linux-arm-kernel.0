From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 05 Feb 2013 13:08:50 +0000
Subject: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
In-Reply-To: <50FEB546.3090504@free-electrons.com>
References: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
 <1356645288-10110-2-git-send-email-maxime.ripard@free-electrons.com>
 <50ED2C2D.7030608@free-electrons.com> <50FEB546.3090504@free-electrons.com>
Message-ID: <20130205130850.544353E0E27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013 16:50:30 +0100, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> On 09/01/2013 09:37, Maxime Ripard wrote:
> > On 27/12/2012 22:54, Maxime Ripard wrote:
> >> The bindings assumed that the gpios properties were always there, which
> >> made the NO_TX and NO_RX mode not usable from device tree. Add extra
> >> checks to make sure that the driver can work if either MOSI or MISO is
> >> not used.
> > 
> > Can you give me your Acked-by on this, or do you have any comments on this?
> 
> Ping?

Mark has applied it and it is now in my tree.

g.
