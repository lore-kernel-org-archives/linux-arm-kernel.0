From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 10 May 2012 05:10:22 +0000
Subject: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
In-Reply-To: <4FA936E8.1080801@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA4035E.6020308@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987147@DBDE01.ent.ti.com>
 <4FA7F232.7050802@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9878EC@DBDE01.ent.ti.com>
 <4FA936E8.1080801@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98A285@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, May 08, 2012 at 20:38:24, Hunter, Jon wrote:

> > Different ways of doing things, this looks cleaner to me as already it is
> > checked, and time of execution in both cases would not differ much.
> 
> Sure. However, I think that this could be simplified so that it is
> easier to read. At a minimum you may wish to add some comments to
> explain the purposes of the multi-level if-statements as it is not
> intuitive for the reader.

Ok

> >> What happens if a device uses more than one wait-pin? In other words a
> >> device with two chip-selects that uses two wait-pins?
> > 
> > Please re-read http://www.mail-archive.com/linux-omap at vger.kernel.org/msg67702.html
> > and your reply
> 
> Ok thats fine. Sorry for my repeated questions, but I think that this
> just highlights that this code is not clear in it purpose. So again may
> be some comments would make this all clearer.

Ok

Regards
Afzal
