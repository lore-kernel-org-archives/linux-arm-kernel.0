From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Mar 2014 18:45:44 +0100
Subject: mvebu: Kirkwood: Device Tree file for Zyxel NSA320
In-Reply-To: <53335D9D.5070100@baker-net.org.uk>
References: <53112C83.9010700@baker-net.org.uk>
 <20140301103417.GK27832@lunn.ch>
 <5313C24A.9070306@baker-net.org.uk>
 <20140303094102.GA13805@lunn.ch>
 <20140326010658.GN28304@titan.lakedaemon.net>
 <53335D9D.5070100@baker-net.org.uk>
Message-ID: <20140328174544.GE22339@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 11:07:09PM +0000, Adam Baker wrote:
> On 26/03/14 01:06, Jason Cooper wrote:
> > Adam,
> > 
> > Any progress on this?
> > 
> > thx,
> > 
> > Jason.
> 
> I think it's about ready, I'm just trying to find time to tidy it up to
> post properly. My current thinking is that it should be split into 3 patches
> 
> 1 - Move some things that are common to both nsa310, nsa310a and nsa320 into
>     kirkwood-nsa310-common.dtsi
> 2 - add the dts for nsa320
> 3 - rename kirkwood-nsa310-common.dtsi to kirkwood-nsa3x0-common.dtsi (I suspect
>     the nsa325 is sufficiently different to not share this file). I suggest
>     making this change last as it can easily be dropped till later if it causes
>     conflicts.
> 
> Current diff for changes 1 & 2 is below in case anyone wants to make any further
> comments.

Hi Adam

I took a quick look. Everything looks O.K. Shame the buzzer does not
work via a simple GPIO.

     Andrew
