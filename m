From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 11 Dec 2015 15:21:53 +0100
Subject: [PATCH 2/2] ARM: mvebu: kirkwood: add PogoPlug series 4 device
 tree
In-Reply-To: <CACRpkdYHk4ZtF-UY7tp9YrGocyqKNCCPLfWheeP4wvAVxJzhHg@mail.gmail.com>
References: <1448578868-6323-1-git-send-email-linus.walleij@linaro.org>
 <20151127202738.GC32356@lunn.ch>
 <CACRpkdYHk4ZtF-UY7tp9YrGocyqKNCCPLfWheeP4wvAVxJzhHg@mail.gmail.com>
Message-ID: <20151211142153.GD12282@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 09:28:54AM +0100, Linus Walleij wrote:
> On Fri, Nov 27, 2015 at 9:27 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> >> +     chosen {
> >> +             bootargs = "console=ttyS0,115200n8";
> >> +             stdout-path = &uart0;
> >
> > Hi Linus
> >
> > You can append the baud rate etc to uart0, and then don't need
> > bootargs.

> However there is also stdout-path, so I went for this:
> 
> stdout-path = "serial0:115200n8";

Hi Linus

Yes, this is what i meant.

     Andrew
