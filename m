From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 10 Nov 2015 19:26:59 +0100
Subject: [PATCH v3 00/12] pwm: add support for atomic update
In-Reply-To: <20151110173416.GB21727@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego> <20151110173416.GB21727@ulmo>
Message-ID: <20151110192659.3eaa800c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Tue, 10 Nov 2015 18:34:16 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St?bner wrote:
> > Hi Thierry,
> > 
> > Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> > > Hello,
> > > 
> > > This series adds support for atomic PWM update, or IOW, the capability
> > > to update all the parameters of a PWM device (enabled/disabled, period,
> > > duty and polarity) in one go.
> > 
> > is anything more blocking this series? It's now sitting on the lists for 
> > nearly a month and everybody seems happy with it, so it would be really nice 
> > to have in mainline :-) .
> > 
> > Especially as this also makes it possible for Rockchip Chromebooks to actually 
> > control the logic-regulator that is implemented as pwm-regulator there.
> 
> Last time I tried to put this into linux-next I got immediately
> bombarded by a number of build failures, so I backed things out. The
> current plan is to give this another try after v4.4-rc1.

Could you paste the build failures (I didn't receive any notification)?
BTW, I just rebased my branch on pwm/for-next and it seems to compile
correctly, but maybe you're compiling on more platforms (or different
drivers than I do).

Best Regards,

Boris



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
