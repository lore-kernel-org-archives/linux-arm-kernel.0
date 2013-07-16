From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Jul 2013 09:44:22 -0400
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <20130716121432.GA2317@localhost>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch> <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch> <20130716121432.GA2317@localhost>
Message-ID: <20130716134422.GE12062@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 09:14:33AM -0300, Ezequiel Garcia wrote:
> On the other side, I'm much interested in knowing if you are OK with
> breaking the watchdog DT compatibility. If you NACK this, then I'll
> start preparing a different watchdog driver for 370/XP, since I don't
> want to extend a driver that is a bit dirty.

Apparently there is some agreement that the bindings are still in flux
and that they need to be for a bit longer in order to hammer out
problems such as this.

Arnd and Olof both mentioned that something (a doc, and email?) is
forthcoming about marking some bindings as stable.  Whatever form that
takes, this one wouldn't get the stable marking yet. ;-)

Oh, and one more nit.  The work 'fix' triggers a whole bunch of "get on
this right away, does it need to go to stable?  Has anyone confirmed it?
Which commit caused the regression? etc."  Although I hate the word, I
think 'refactoring' is much more appropriate description for this series.

thx,

Jason.
