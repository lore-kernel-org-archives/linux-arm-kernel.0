From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 5 Aug 2013 10:43:35 +0200
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FECB7A.6010208@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com>
Message-ID: <20130805104335.031b0fed@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian, Russell,

On Sun, 04 Aug 2013 23:45:30 +0200, Sebastian Hesselbarth wrote:
> On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:
> > This is only a RFC at present due to the need to test on Kirkwood and
> > fix at least one bug in ASoC core code.
> >
> > I can't say that this stuff is fully tested, because I don't have any
> > Kirkwood platforms, but I do have one Dove platform, which as I've
> > said in the past doesn't run mainline.  I don't run DT on it, so these
> > patches also don't contain anything DT related.
> 
> Added Thomas Petazzoni to Cc, IIRC he has access to a T5325.

Yes, I have access to a Kirkwood t5325, which I'm currently trying to
move to DT. Note that I also received Armada 370 audio hardware last
week, so I'll be working on this as well in the future, this hardware
has both in/out jack plugs as well as SPDIF ones.

So, yes, please Cc me on Kirkwood audio related developments.

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
