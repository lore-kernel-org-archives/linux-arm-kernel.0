From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Sep 2016 16:33:17 +0200
Subject: [PATCH 4/7] drm/panel: Add Sinlinx SinA33 7" panel
In-Reply-To: <20160906091224.GC15644@ulmo.ba.sec>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-5-maxime.ripard@free-electrons.com>
 <66681473008583@web28j.yandex.ru> <20160905200248.GB8596@lukather>
 <20160906091224.GC15644@ulmo.ba.sec>
Message-ID: <20160906143317.GG9040@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 11:12:24AM +0200, Thierry Reding wrote:
> On Mon, Sep 05, 2016 at 10:02:48PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > On Mon, Sep 05, 2016 at 01:03:03AM +0800, Icenowy Zheng wrote:
> > > Hi Everyone,
> > > 
> > > 01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > > > ?The SinA33 has an unidentified panel. Add the timings for it under a new
> > > > ?compatible.
> > > 
> > > 
> > > 
> > > Excuse me...
> > > I will ask a question which is not fully related to the patch here...
> > > If I want to add a generic panel for Q8 tablets, what should it be called?
> > > "allwinner,q8-lcd-panel-800x480"?
> > 
> > I guess it's more of a question for Thierry, but it seems like the
> > trend is to put the diagonal rather than the resolution in the
> > compatibles.
> 
> Compatible strings should contain the model number of the panel. There
> is no such thing as a "generic panel for Q8 tablets".
> 
> Also, how is it that these panels are unidentified? Has nobody tried to
> open them up and look at the panel to find a model number?

It is not always possible without breaking the device apart. And I can
understand not a lot of people want to do that.

But on that particular patch, I had a bunch of spare ones, and ended
up doing just that. The reference is from an unknown brand, but at
least the part number shows up on Google, I'll use that.

Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/dcec7aca/attachment.sig>
