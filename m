From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 15:20:57 -0700
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <4961691.1JRP1YEOt8@wuerfel>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140708124653.GX23978@titan.lakedaemon.net>
 <20140717123550.GH13108@titan.lakedaemon.net>
 <4961691.1JRP1YEOt8@wuerfel>
Message-ID: <20140718222057.GA13234@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 03:29:53PM +0200, Arnd Bergmann wrote:
> On Thursday 17 July 2014 08:35:50 Jason Cooper wrote:
> > Olof, Arnd, please merge this request.  I can re-send if you need.
> > 
> > We have more changes pending in mvebu/dt on top of this, and we're
> > getting very close to the cutoff for the merge window.
> 
> Please send both pull requests now so we can look at the whole
> picture. No need for you to wait for this to be merged before
> sending the follow-up pull request.
> 
> I think we should just merge, there is no nice solution for
> the technical problem and the approach you have taken looks
> like the least problematic one to me.
> 
> Olof, any further thoughts on this?

I have a CuBox, and based on USB id for the UART, it's an ES model.

Since the only thing that breaks seems to be SD, I can personally live with
that just fine even if I have to refer to the non-ES dtb for backwards
compatibility.

If this requires more discussion then the obvious solution is to leave out
these patches and send the superceding DT pull request of a branch that doesn't
have them. I think we can take this as it is for now though -- I suspect in
reality the number of affected ES owners should be pretty small?


-Olof
