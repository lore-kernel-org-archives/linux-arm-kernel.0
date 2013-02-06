From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Feb 2013 23:19:05 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <20130126084604.GB8754@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
Message-ID: <alpine.DEB.2.00.1302062318450.12769@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Jan 2013, Felipe Balbi wrote:

> Hi,
> 
> On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> > Boot tests:
> > 
> > * am335xbone: hangs after "Starting kernel"
> >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
> >   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
> >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> 
> FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> to help my bone, no matter if I had appended DTB or not.

Thanks, I've adjusted the (upcoming) message for v3.8-rc6 accordingly.


- Paul
