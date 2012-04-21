From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 12:24:47 +0000
Subject: [PATCH 0/9] Add support for SPEAr13xx SoCs
In-Reply-To: <CAOh2x=kX93nDDTfVq-ERBF=UDRZAUSwnwCuO35R+E-SZjcFUag@mail.gmail.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201821.28266.arnd@arndb.de>
 <CAOh2x=kX93nDDTfVq-ERBF=UDRZAUSwnwCuO35R+E-SZjcFUag@mail.gmail.com>
Message-ID: <201204211224.47826.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, viresh kumar wrote:
> On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:
> > I've looked at all the platform specific bits and they look pretty good,
> > great work! I have ignored the pinctrl and clock drivers and hope that the
> > respective maintainers will be able to judge them well.
> >
> > There are a few places where you still hardcode stuff that could be turned
> > into device tree properties, but those are corner cases and you have an
> > existing platform here that you've done a great amount of excellent cleanups
> > to in the last weeks, so my feeling is that all the platform code can go in
> > when you take care of the stuff that I've commented on, most of those things
> > should be simple.
> 
> Have fixed most of stuff you pointed to. Check V2.
> 

Wow, that was fast ;-)

Can you comment on the ones you did not address? In particular,
I'd like to understand why you put the SPEAR1310_RAS_CTRL*
register definitions into a globally visible header file.

	Arnd
