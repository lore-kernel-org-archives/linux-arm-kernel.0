From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Jan 2015 23:56:14 +0100
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150106224622.GA13752@saruman>
References: <20150106170433.GA5408@amd> <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd> <20150106202857.GB32308@saruman>
 <20150106205000.GB13902@amd>
 <20150106205730.GA6071@fuloong-minipc.musicnaut.iki.fi>
 <20150106220805.GD13902@amd>
 <20150106222717.GC6071@fuloong-minipc.musicnaut.iki.fi>
 <20150106224622.GA13752@saruman>
Message-ID: <20150106225614.GA31990@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-06 16:46:22, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Jan 07, 2015 at 12:27:17AM +0200, Aaro Koskinen wrote:
> > But I'm mounting it from userspace (using builtin initramfs inside
> > zImage), with a poll loop that waits for a device to appear. Maybe if you
> > do it from kernel you need to use root wait/delay etc. options?
> 
> yeah, rootwait should do it.

No, rootwait does not solve it. Try it. Tested many times. (And yes,
you need to actually fool the rear cover sensor or close the phone.)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
