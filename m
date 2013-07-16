From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 16 Jul 2013 11:04:36 -0300
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <20130716134422.GE12062@titan.lakedaemon.net>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch> <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch> <20130716121432.GA2317@localhost>
 <20130716134422.GE12062@titan.lakedaemon.net>
Message-ID: <20130716140435.GA23904@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 09:44:22AM -0400, Jason Cooper wrote:
> On Tue, Jul 16, 2013 at 09:14:33AM -0300, Ezequiel Garcia wrote:
> > On the other side, I'm much interested in knowing if you are OK with
> > breaking the watchdog DT compatibility. If you NACK this, then I'll
> > start preparing a different watchdog driver for 370/XP, since I don't
> > want to extend a driver that is a bit dirty.
> 
> Apparently there is some agreement that the bindings are still in flux
> and that they need to be for a bit longer in order to hammer out
> problems such as this.
> 
> Arnd and Olof both mentioned that something (a doc, and email?) is
> forthcoming about marking some bindings as stable.  Whatever form that
> takes, this one wouldn't get the stable marking yet. ;-)
> 

Yup, that's my understanding as well. But on the other side, I don't
want to break possible users out there.

So, just to check, you say it's early enough to safely do such change?

In that case, I'll extend this patchset to include Armada 370/XP support
and post it as soon as Sebastian's clocksource stuff gets in.

> Oh, and one more nit.  The work 'fix' triggers a whole bunch of "get on
> this right away, does it need to go to stable?  Has anyone confirmed it?
> Which commit caused the regression? etc."  Although I hate the word, I
> think 'refactoring' is much more appropriate description for this series.
> 

Oh, good observation. I wrote the cover letter at 8 PM, after ten long
hours (*) of hacking and smashing this into something easy to review,
and that's the best title I could come up with. I'll change it on v2.

Thanks,

(*) yes, I have another pair of eyes, in case these wear out.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
