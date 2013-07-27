From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 27 Jul 2013 10:53:01 +0200
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130726171524.GB28895@obsidianresearch.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
Message-ID: <20130727085259.GA6207@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:15:24AM -0600, Jason Gunthorpe wrote:
> On Fri, Jul 26, 2013 at 06:54:33AM +0200, Richard Cochran wrote:
> > I too work on commercial embedded systems, and DT has proven to be
> > one gigantic *PITA*.
> 
> Why do you think our experiences are so different?

Here are a few recent examples:

* What happens when one wants to boot vanilla kernel on the beaglebone?

  http://www.spinics.net/lists/arm-kernel/msg198431.html

* Wanting already merged code to work is too much to ask.

  http://www.spinics.net/lists/linux-omap/msg79731.html

* When people try in good faith to conduct methodical boot tests,
  DT is working against them.

  http://www.spinics.net/lists/linux-omap/msg79960.html

Thanks,
Richard
