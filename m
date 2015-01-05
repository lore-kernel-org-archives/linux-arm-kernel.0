From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Jan 2015 14:43:35 +0000
Subject: [PATCH 4/5] cpufreq: imx6q: add ldo-bypass support
In-Reply-To: <CAJ+vNU0S_=H=VDwxUXBGyNrvjg5MRe3UP-UV9Xnj3MkNdWM0ng@mail.gmail.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
 <1414729631-11005-5-git-send-email-tharvey@gateworks.com>
 <CAOMZO5DzEe91pTv+UkCbj0DzgVDOb9hjuakt9NmpTJnEk-j8UA@mail.gmail.com>
 <CAJ+vNU3PQYCE4tABUiqU+vGkGqBEqdVKz25W88-ByOQZxunVLw@mail.gmail.com>
 <20141218142205.GZ11764@sirena.org.uk>
 <CAJ+vNU1YQWGFaEm8w8wtaFvUy1jig26jW3+3teMFHLB_oFyn8Q@mail.gmail.com>
 <20141219162343.GF11764@sirena.org.uk>
 <CAJ+vNU0S_=H=VDwxUXBGyNrvjg5MRe3UP-UV9Xnj3MkNdWM0ng@mail.gmail.com>
Message-ID: <20150105144335.GR11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 06:38:50AM -0800, Tim Harvey wrote:
> On Fri, Dec 19, 2014 at 8:23 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Dec 19, 2014 at 08:17:41AM -0800, Tim Harvey wrote:

> >> frequency setpoint. If however you have an external PMIC that is
> >> capable of adjusting the VDD_ARM and VDD_SOC to the IMX6 and an
> >> appropriate regulator driver is capable of doing so, you must
> >> configure the cpu nodes vddarm and vddsoc regulators to those provided
> >> by your PMIC and 'bypass' the internal LDO's by setting their scaling

> > You're describing the implementation again, not the system.  Describe
> > the system then if you want to describe the solution you've come up with
> > for modelling it do so separately.

> > Please also try to use paragraphs to break up what you're saying a bit.

> I'm not sure I'm understanding what your asking for or how to describe
> it differently. Fabio / Shawn / Philipp could you help me out here
> with the proper explanation of the IMX6 LDO's so that we can make some
> progress on getting LDO bypass implemented?

I have no idea what the context is any more, sorry.  The above looks
like you're talking about the specifics of how you've implemented
something instead of describing the hardware you're trying to abstract -
you're taling about the "cpu nodes" in what sounds like it's supposed to
be a description of the hardware for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/ed045e38/attachment.sig>
