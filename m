From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Sep 2012 19:27:47 +0000
Subject: [PATCH V2] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <504B8359.80403@wwwdotorg.org>
References: <1347083284-17799-1-git-send-email-swarren@wwwdotorg.org>
 <504B3BED.9080204@simon.arlott.org.uk> <504B8359.80403@wwwdotorg.org>
Message-ID: <9292467.5Y4vCKkKhh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 September 2012 11:41:45 Stephen Warren wrote:
> On 09/08/2012 06:37 AM, Simon Arlott wrote:
> > On 08/09/12 06:48, Stephen Warren wrote:
> 
> > I don't know what you're trying to achieve. This does not add support
> > for the BCM2708.
> 
> I'm trying to get upstreaming started, a little bit at a time. Right
> now, all work has been done outside the regular Linux ARM community. I
> feel it'd be much better to start feeding the work upstream. This will
> provide much better exposure for the work, and put it into a place
> that's more obvious for users, and useful for distros.
> 
> Obviously, the next step after this patch is to upstream the interrupt
> controller and timer, to resolve the problem mentioned above. There's
> certainly still much more to do after that.

I think it would be good to get those reviewed and submitted in time for
the merge window, to have something that actually boots.

I agree that for review purposes starting out with just the minimal patch
was a good idea, but when the other stuff looks reasonable, we should also
try to get it in at the same time.

	Arnd
