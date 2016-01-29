From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 16:48:33 +0100
Subject: [PATCH 0/9] ARM: pxa/mmp cleanups and warning fixes
In-Reply-To: <87io2c76hh.fsf@belgarion.home>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
 <87io2c76hh.fsf@belgarion.home>
Message-ID: <24241162.8H4bJ4YIKl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 January 2016 16:25:30 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > These are all fixes for harmless warnings, aside from the first
> > patch, which is a cleanup. Please pick them up into the PXA
> > tree (my preference), or provide an Ack so I can put them
> > into arm-soc.
> Hi Arnd,
> 
> I'll pick them up, provided the acks (for clock tree for example). The
> pxa-for-4.6 will happen.
> 
> I'll just have a check on 1/9 to verify nobody hides in a corner a direct CKEN
> access, and try to understand more thoroughly 7/9, all the others look good to
> me.

Ok, sounds good. If you are unsure about it, you can also drop that
one or do a broader version of it that does the other registers as well.
I don't think it caused any compiler warnings, which is what I'm trying
to handle right now.

> As for the 9th patch, it's in the MMP tree. I can carry it if Haojian wishes,
> but I need his ack.
> 

Makes sense.

	Arnd
