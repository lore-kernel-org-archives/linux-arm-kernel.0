From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 12:33:45 +0200
Subject: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
In-Reply-To: <20160711100629.GJ5823@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
 <20160711095623.GI5823@ulmo.ba.sec>
 <20160711100629.GJ5823@ulmo.ba.sec>
Message-ID: <20160711103345.GB5503@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:06:29PM +0200, Thierry Reding wrote:
> On Mon, Jul 11, 2016 at 11:56:23AM +0200, Thierry Reding wrote:
> > On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> > > Replace unit address from 0 to the proper physical address. Also insure
> > > that the unit address matches the reg property address.
> > > 
> > > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > I applied this long ago but never let you know: Applied, thanks.
> 
> Actually I didn't. And it seems the reason is that it doesn't apply
> cleanly. For some reason my tree doesn't have an entry for the ecap
> example on am437x. Am I missing a patch? Can you resend whatever is
> not in linux-next yet?

Oh, nevermind my blabbering, it took me too long to realize that this is
the series that Tony had picked up for the most part, and I hadn't
properly marked it done in patchwork.

I'll go get some coffee now.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/45d4cb0b/attachment-0001.sig>
