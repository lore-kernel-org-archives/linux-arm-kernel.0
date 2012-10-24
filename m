From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:19:08 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <50884C12.7050809@gmail.com>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-2-git-send-email-andrew@lunn.ch>
 <20121024213128.2d4c07dc@skate> <50884659.1020208@gmail.com>
 <20121024220021.148a88ff@skate> <50884C12.7050809@gmail.com>
Message-ID: <20121024221908.081b1a8d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, 24 Oct 2012 22:14:10 +0200, Sebastian Hesselbarth wrote:

> > Where did I say that you should define *all* possible configurations?
> >
> > I said: "The SoC .dtsi file should define all the pinmux groups that are
> > described in the datasheet and are used by boards". Read again the "and
> > are used by boards".
> 
> Ok, then I overread "and used by other boards". Sorry for that.

No problem :)

> > So I'm clearly not advocating adding *all* possible configurations,
> > because there would be gazillions of them. But I'm in favor of moving
> > the *used* configurations to the .dtsi files.
> 
> Agreed.

Great!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
