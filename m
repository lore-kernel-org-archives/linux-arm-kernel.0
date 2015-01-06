From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 17:04:15 -0600
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150106225614.GA31990@amd>
References: <20150106170433.GA5408@amd> <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd> <20150106202857.GB32308@saruman>
 <20150106205000.GB13902@amd>
 <20150106205730.GA6071@fuloong-minipc.musicnaut.iki.fi>
 <20150106220805.GD13902@amd>
 <20150106222717.GC6071@fuloong-minipc.musicnaut.iki.fi>
 <20150106224622.GA13752@saruman> <20150106225614.GA31990@amd>
Message-ID: <20150106230415.GC13752@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 11:56:14PM +0100, Pavel Machek wrote:
> > > But I'm mounting it from userspace (using builtin initramfs inside
> > > zImage), with a poll loop that waits for a device to appear. Maybe if you
> > > do it from kernel you need to use root wait/delay etc. options?
> > 
> > yeah, rootwait should do it.
> 
> No, rootwait does not solve it. Try it. Tested many times. (And yes,
> you need to actually fool the rear cover sensor or close the phone.)

yeah, just put a magnet or, if you have spare back covers, cut one so
that you "close" it, but still allow you to put the thing on a
development jig.

Also, if why doesn't rootwait work ? You never have a new mmc node or is
the mmc node changing names ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/abeafef3/attachment-0001.sig>
