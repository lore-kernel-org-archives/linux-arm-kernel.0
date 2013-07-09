From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jul 2013 22:21:43 +0200
Subject: NSA310 + DT
In-Reply-To: <20130709193605.GC26223@lunn.ch>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
Message-ID: <20130709202143.GD26223@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 09:36:05PM +0200, Andrew Lunn wrote:
> On Tue, Jul 09, 2013 at 08:28:26PM +0200, Tibor Harsszegi wrote:
> > Hello Andrew,
> > 
> > sorry to bug you, but honestly couldn't find better way than this :(
> 
> Hi Tibor
> 
> Its not a problem to bug me, but please also CC: the arm kernel
> mailing list. This board port was contributed by Tero Jaasko
> <tero.jaasko@gmail.com>, so its good to also ask him.
> 
> > I have some issues.
> 
> A basic question to start with. Are you using the default kernel
> configuration for kirkwood? Which kernel version are you using?
>  
> > a.) With the current NSA310 .dts the sensors are not working (at
> > least on my NSA310). The reason is that the i2c sensors is a lm85
> > kind

Hi Tibor

Which NSA310 do you actually have? Apparently there are actually two
variants:

http://zyxel.nas-central.org/wiki/Category:NSA-310

It could be yours is actually the rebranded TDC Homedisk. If so, we
should add a new .dts file for it.

       Andrew
