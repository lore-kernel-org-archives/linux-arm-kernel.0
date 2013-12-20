From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 19 Dec 2013 19:57:58 -0500
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <87sitoka39.fsf@natisbad.org>
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <87sitoka39.fsf@natisbad.org>
Message-ID: <20131220005758.GA2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 06:46:18PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > On Thu, Dec 19, 2013 at 05:34:09PM +0100, Arnaud Ebalard wrote:
> >> I have a very simple driver (support for reading and setting the time)
> >> for a RTC chip (Intersil ISL 12057) but cannot find anyone to get it
> >> Acked and queued for v3.14. In v3.14, there should be at least three
> >> users of the driver (ReadyNAS 102, 104 and 2120) if I meet -rc5 cutoff
> >> for associated .dts changes.
> >
> > The -rc5 cutoff isn't a hard line.  It's also mvebu-specific.  eg, We
> > need things _posted_ a week or so before arm-soc's cutoff of -rc6 so we
> > have time to get the pull request in.  If it needs to go through
> > mvebu/arm-soc, once it's posted, you're good.
> 
> I understand. But I guess you will not (for valid reason) accept .dts
> changes to reference a rtc driver that is not on good track towards
> -next. This is the issue I try and solve.

Just a subtle note here.  If the binding is stabilized, I don't mind
taking the dts changes.  However, if we have time, I prefer to wait for
the whole series to be hashed out.  You never know which resolutions
will end up revisiting the bindings you thought were good. :)

So, it's technically not a requirement for the whole driver to be
settled, but it is a good idea.

thx,

Jason.
