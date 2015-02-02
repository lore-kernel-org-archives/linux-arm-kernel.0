From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 1 Feb 2015 21:24:23 -0800
Subject: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
In-Reply-To: <54CF07F3.2040100@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <54CE53F3.5040709@hurleysoftware.com>
 <54CE6FD9.5030606@hurleysoftware.com>
 <1422846994.5512.25.camel@mtksdaap41>
 <54CEF2C8.1050808@hurleysoftware.com>
 <20150202042843.GA24765@kroah.com>
 <54CF07F3.2040100@hurleysoftware.com>
Message-ID: <20150202052423.GA3346@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:15:31AM -0500, Peter Hurley wrote:
> On 02/01/2015 11:28 PM, Greg Kroah-Hartman wrote:
> > On Sun, Feb 01, 2015 at 10:45:12PM -0500, Peter Hurley wrote:
> >> On 02/01/2015 10:16 PM, Eddie Huang wrote:
> 
> >> I'll respin proper patches on top of Greg's tty-testing branch with reverts
> >> for the noinit options. I noticed that one of the noinit patches actually
> >> has the linkage for the mtk earlycon, so I'll be sure to preserve that.
> > 
> > I can just drop the patches in the tty-testing branch, that's what it is
> > there for :)
> > 
> > Just let me know the specific patches and I will do so, thanks.
> 
> Well that pretty much means dropping the 3 patches that add earlycon to
> 8250_mtk and then applying my patch (needs fixed to apply cleanly, which
> I can do) and then applying a fixed-up replacement patch to add earlycon
> to 8250_mtk (which I can also supply).
> 
> Is that the way you want to go?

Sounds good to me, send your patch, and I'll fix it all up tomorrow.

thanks,

greg k-h
