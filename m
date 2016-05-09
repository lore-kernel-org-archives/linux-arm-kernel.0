From: robin@protonic.nl (Robin van der Gracht)
Date: Mon, 9 May 2016 09:06:15 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <5723755D.9060108@ti.com>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather> <5723755D.9060108@ti.com>
Message-ID: <20160509090615.6272f8ca@erd979>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2016 17:53:17 +0300
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

[...] 
> >>
> >> Small problem for me, but Robin is submitting a brand new
> >> auxdisplay driver:
> >> http://marc.info/?l=linux-kernel&m=146001950512999&w=2
> >> http://marc.info/?l=linux-kernel&m=146001988013230&w=2  
> > 
> > My understanding is that Tomi doesn't want any new fbdev drivers, so
> > I'm not sure this is the right place for those patches.  
> 
> Hmm, that one looks like an fbdev driver, not an auxdisplay driver.
> But, not relevant for this patch, of course.

If you guys feel like auxdisplay is not the right subsystem for the
driver, and would like me to move it, please share.

Regards,
Robin van der Gracht
