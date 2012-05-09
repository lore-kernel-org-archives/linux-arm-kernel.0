From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Wed, 9 May 2012 20:38:16 +0000
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <20120509122436.1b612004.akpm@linux-foundation.org>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <CAK5ve-KSyvZSHw7csQ5M88q0008NSrs1kwuyUH3hFqxD0f7BQQ@mail.gmail.com>
 <20120509122436.1b612004.akpm@linux-foundation.org>
Message-ID: <201205092038.16722.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Andrew Morton wrote:
> I'm the LEDs patchmonkey at present.  I can merge the drivers/leds
> change if you like, but there doesn't seem much point in that unless
> all the other patches get merged.
> 
> So my preferred approach would be for the patch series to get merged
> via some ARM tree.

I'm fine with taking it through arm-soc if that helps. In the long run,
it would be nice to have a proper maintainer for this again after Richard
more or less stepped down from that position. Given that Bryan has shown
that he's persistent enough to get this patch series to v9, how about
making him the primary maintainer for the entire subsystem? He should
know a lot about it already. Bryan?

	Arnd
