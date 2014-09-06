From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 6 Sep 2014 11:38:34 -0700
Subject: [PATCH 2/7] ARM: meson: serial: add MesonX SoC on-chip uart driver
In-Reply-To: <20140906182804.GA14240@nuc>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-3-git-send-email-carlo@caione.org>
 <20140906182804.GA14240@nuc>
Message-ID: <20140906183834.GA28645@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 08:28:04PM +0200, Carlo Caione wrote:
> On dom, ago 17, 2014 at 12:49:49 +0200, Carlo Caione wrote:
> > The SoC has four fully functional UARTs which use the same programming
> > model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> > which cannot be powered off.
> > 
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> > ---
> 
> Ping

It's still in my queue, sorry, been busy with conferences and the like,
should get to everything next week...

greg k-h
