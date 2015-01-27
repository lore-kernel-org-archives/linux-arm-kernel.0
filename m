From: ats@offog.org (Adam Sampson)
Date: Tue, 27 Jan 2015 18:25:33 +0000
Subject: [PATCH] ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board
In-Reply-To: <20150127170035.GJ7200@lukather>
References: <1422199921-325-1-git-send-email-ats@offog.org>
 <20150125164846.GL8470@lukather>
 <20150126003520.GA871@cartman.at.offog.org>
 <20150126100921.GQ8470@lukather>
 <20150126135931.GB871@cartman.at.offog.org>
 <20150127170035.GJ7200@lukather>
Message-ID: <20150127182533.GE871@cartman.at.offog.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:00:35PM +0100, Maxime Ripard wrote:
> > How about pcduino3-nano:green:usr-led3/4? Or ...:usr1/2, and a comment
> > in the .dts explaining how they're labelled on the board?
> The latter looks better yes. tx and rx would do too, if you know what
> tx and what rx we're talking about here.

I've changed it to usr1/2 with comments. (I don't know if they were
intended to be TX/RX; the documentation doesn't suggest so.)

> > They're multipurpose pins on Arduino-compatible headers:
...
> > So should we [...]
> None of the above, if there's no hardware default, we won't enforce
> any default either. This is a case for the DT overlays.

OK -- that simplifies it quite a bit, then. v3 of the patch incoming!

Thanks very much,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
