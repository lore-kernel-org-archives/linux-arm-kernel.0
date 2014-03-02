From: tony@atomide.com (Tony Lindgren)
Date: Sun, 2 Mar 2014 09:07:58 -0800
Subject: [PATCH 00/11] ARM: dts: sbc-t3x: add support for more boards
In-Reply-To: <53133D11.7000502@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
 <52FB6B2E.9070106@compulab.co.il> <5309E9EE.2040705@compulab.co.il>
 <20140228221219.GH13624@atomide.com>
 <53133D11.7000502@compulab.co.il>
Message-ID: <20140302170757.GA18496@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [140302 06:19]:
> On 03/01/14 00:12, Tony Lindgren wrote:
> > * Igor Grinberg <grinberg@compulab.co.il> [140223 04:33]:
> >> ping x2!
> > 
> > Thanks applying into omap-for-v3.15/dt finally.
> 
> Thanks!
> 
> > 
> > Is it OK to remove the board-cm-*.c files for v3.15?
> 
> Hmmm....
> I thought we will have a transition release with both ways and
> similar functionality available...
> For this to happen, we need to extend the DT support to the stuff
> board-cm-t*.c files cover before removing them...
> We should be able to send additional patches in 3-5 weeks.
> Since rc4 is out a week ago, and rc5 is coming, we won't be able
> to prepare the extension in time for 3.15...
> So, can we postpone the board-cm-t*.c files removal to 3.16?
> Or does it make too much trouble for you?

OK that sounds good to me thanks!

Tony
