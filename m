From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Wed, 22 Dec 2010 11:45:18 +0200
Subject: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
In-Reply-To: <20101222085638.226a1269.jhnikula@gmail.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
	<20101221202133.GJ5829@atomide.com>
	<20101222085638.226a1269.jhnikula@gmail.com>
Message-ID: <1293011118.6829.0.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-22 at 08:56 +0200, ext Jarkko Nikula wrote:
> On Tue, 21 Dec 2010 12:21:33 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Jarkko Nikula <jhnikula@gmail.com> [101221 09:25]:
> > > Hi
> > > 
> > > Commit 60d24ee "Added video data to support tvout on rx51" broke the
> > > framebuffer on N900. Here are two patches where 1st one does a little cleanup
> > > to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
> > > are working.
> > 
> > Tomi, do you want to pick these three DSS/video related patches from Jarkko?
> > 
> > If so:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > else please ack and let me know if you want me to take them.
> > 
> I think these should go to linux-omap since the breakage is there and
> anyway touch only the rx51 board files.

I agree, I don't have that commit in my tree. So Tony, please take the
patches.

For both patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tomi
