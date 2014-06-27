From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Jun 2014 09:37:18 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140627130430.GH32514@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk>
Message-ID: <20140627133718.GI23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 02:04:30PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 09:01:29AM -0400, Jason Cooper wrote:
> > Sebastian Hesselbarth (2):
> >       dt-binding: add vendor prefix for SolidRun
> >       ARM: dts: mvebu: split SolidRun CuBox into variants
> 
> Are we sure about this?  I mean, in order to find out whether mine is an
> engineering sample or not, I had to ask Rabeeh, and Rabeeh had to ask
> various questions about the exterior construction in order to identify
> which mine was.

What were the specific details Rebeeh use to differentiate ES and
production?  Is it something generic we could put in a comment?

Sebastian, what happens when the wrong dtb is loaded?  afaict, card
detect won't work for the sd card.  Which isn't earth-shattering, but I
know at least the Debian guys are going to want a programmatic way to
determine which board they are on.

thx,

Jason.
