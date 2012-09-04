From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Tue, 04 Sep 2012 18:12:28 +0100
Subject: [PATCH 06/11] clk: Common clocks implementation for Versatile
 Express
In-Reply-To: <CACRpkdbKeQ_QYBpc2UJKA7QRWvZ-J1Tnhe7z_tevE_-rULd69w@mail.gmail.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
 <201209032124.02224.arnd@arndb.de> <1346759602.2605.69.camel@hornet>
 <CACRpkdbKeQ_QYBpc2UJKA7QRWvZ-J1Tnhe7z_tevE_-rULd69w@mail.gmail.com>
Message-ID: <1346778748.18716.2.camel@vaio>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 14:43 +0200, Linus Walleij wrote:
> On Tue, Sep 4, 2012 at 1:53 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > But we are still "CLCD driver away" from the full features
> > replacement. Ryan Harkin is working on this,
> 
> Will be useful for Integrator, Versatile, RealView, and some non-ARM
> SoCs too I think, so very interesting!

Well, we already have a patch set in our tree [1] that will support CLCD
in Device Tree, however, I have yet to get this reviewed, despite Pawel
reminding me about it, er, occasionally.

I guess that now we've seen it working on several tiles and FastModel, I
should get on with it...

I expect significant changes, particularly with the DT bindings, before
this will be acceptable upstream.

Cheers,
Ryan.

[1]
http://git.linaro.org/gitweb?p=landing-teams/working/arm/kernel.git;a=shortlog;h=refs/heads/tracking-armlt-clcd
