From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 30 Jan 2018 11:00:23 +0100
Subject: [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180130093838.GA15195@lenoch>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch>
Message-ID: <20180130100023.GB18104@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijevi? wrote:
> > Hi,
> > 

> > > Well, notice I'm converting existing driver to device tree. And that
> > > one already has GPIO dependency. It is possible that more work needs
> > > to be done there, but that should not be a reason to delay this. Feel
> > > free to help.
> 
> Adding DT properties that need to be maintained for compatibility reasons
> is a bad idea and very good reason to delay merging unfinished stuff.
> And meanwhile it turned out it is not power-gpio :)

I believe reset-gpios and power-gpios are commonly used like
this... and that's what the old code does.

You are not helping.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/b94ef21b/attachment.sig>
