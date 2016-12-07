From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 7 Dec 2016 15:55:55 +0100
Subject: [RFC PATCH v3 2/2] drm/panel: Add support for Chunghwa
 CLAA070WP03XG panel
In-Reply-To: <2C9FE0C5-F521-48CD-B274-66128312CA75@soulik.info>
References: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
 <1474311771-23321-3-git-send-email-ayaka@soulik.info>
 <20161206154625.GA28534@ulmo.ba.sec>
 <2C9FE0C5-F521-48CD-B274-66128312CA75@soulik.info>
Message-ID: <20161207145555.kdg7azcrpnwnb2r6@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 08:57:23AM +0800, Ayaka wrote:
> 
> 
> ??? iPad ??
> 
> > Thierry Reding <thierry.reding@gmail.com> ? 2016?12?6? ??11:46 ???
> > 
> >> On Tue, Sep 20, 2016 at 03:02:51AM +0800, Randy Li wrote:
> >> The Chunghwa CLAA070WP03XG is a 7" 1280x800 panel, which can be
> >> supported by the simple panel driver.
> >> 
> >> Signed-off-by: Randy Li <ayaka@soulik.info>
> >> ---
> >> .../display/panel/chunghwa,claa070wp03xg.txt       |  7 ++++++
> >> drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
> >> 2 files changed, 34 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/display/panel/chunghwa,claa070wp03xg.txt
> > 
> > Applied, thanks.
> Wait, it is RFC, not pass the test.

Well 2 months of silence, it's reasonable to assume that this works for
you ... I guess you need to supply a fixup patch asap ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
