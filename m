From: greg@kroah.com (Greg KH)
Date: Thu, 16 Jun 2011 08:16:28 -0700
Subject: [PATCH 1/2] amba pl011: workaround for uart registers lockup
In-Reply-To: <BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
References: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
Message-ID: <20110616151628.GA30881@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 10:17:51AM +0200, Linus Walleij wrote:
> On Mon, Jun 13, 2011 at 10:11 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> 
> > From: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> >
> > This workaround aims to break the deadlock situation
> > which raises during continuous transfer of data for long
> > duration over uart with hardware flow control. It is
> > observed that CTS interrupt cannot be cleared in uart
> > interrupt register (ICR). Hence further transfer over
> > uart gets blocked.
> 
> Ping on this, Greg have you picked these two for the tty next tree?

They are in my "to-apply" queue, and not lost, but been busy with "real
work" lately, so have been slow to get to them, sorry.

greg k-h
