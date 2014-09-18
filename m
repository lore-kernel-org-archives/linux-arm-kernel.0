From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 19 Sep 2014 01:20:52 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917234036.GC2464@xora-yoga-13>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <201409180122.10631.arnd@arndb.de> <20140917234036.GC2464@xora-yoga-13>
Message-ID: <6318202.hl003vettj@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 17, 2014 04:40:36 PM Graeme Gregory wrote:
> On Thu, Sep 18, 2014 at 01:22:10AM +0200, Arnd Bergmann wrote:
> > On Wednesday 17 September 2014, Graeme Gregory wrote:
> > > It sounds like from the discussions in other threads that ARM64 should
> > > be following x86 and re-using DT bindings here. In which case there is
> > > not need to submit things to UEFI organisation.
> > > 
> > > What I got a little lost in has there been a formal decision about DT
> > > bindings in _DSD?
> > 
> > I think this is a discussion that still needs to happen: either we should
> > recommend everyone to use _DSD in favor of the alternatives, or we
> > should prohibit the use of _DSD. I have heard arguments both ways, but
> > hopefully we can find an easy answer.
> > 
> 
> This discussion is just not going to happen until people at @redhat.com
> and people who have currently announced/released hardware are actually
> willing to start talking about it.
> 
> Id love to be able to put my foot down and ban the use of _DSD for
> servers but I suspect that will not happen.

I'll probably should stay away from this discussion, but I can't resist. :-)

Please imagine the situation in which the same IP block is included in an ARM64
SoC and in an x86 SoC that ships with ACPI tables and a _DSD for that device in
them.  What benefit would be there from disallowing systems based on the ARM64
SoC in question to ship the same _DSD in their ACPI tables?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
