From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 15 May 2013 08:34:51 -0400 (EDT)
Subject: [RFC PATCH 1/2] ARM: delay: print dummy values for bogomips
In-Reply-To: <20130515114737.GA7900@amd.pavel.ucw.cz>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <1367602547-19322-2-git-send-email-will.deacon@arm.com>
 <20130506231554.GB16801@amd.pavel.ucw.cz> <5188B8B2.5030601@arm.com>
 <alpine.LFD.2.03.1305141547180.31158@syhkavp.arg>
 <CAL_Jsq+Q5UMGo3J+vKKCRU+w4Kj0YN0exs7UCWTEOxmFjWfo3g@mail.gmail.com>
 <alpine.LFD.2.03.1305141945160.31158@syhkavp.arg>
 <20130515090103.GA12907@mudshark.cambridge.arm.com>
 <20130515114737.GA7900@amd.pavel.ucw.cz>
Message-ID: <alpine.LFD.2.03.1305150830540.31158@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 May 2013, Pavel Machek wrote:

> On Wed 2013-05-15 10:01:03, Will Deacon wrote:
> > My second (less stupid) version of the patch prints "not reported".

Even then, you should tell the truth and say "not available" or "not 
applicable".

> > I'd be happy to remove the line altogether if people get behind the 
> > decision though.

You certainly have my ACK.

> > In fact, I just tried it and at least my linaro filesystem seems happy
> > enough.
> 
> Would it be too much work to simply put the field back with the right
> value? We don't have to get it as precise as we used to, that should
> make slowdown minimum.

There is simply no right value.  And whenever there is a value, people 
read too much into it.


Nicolas
