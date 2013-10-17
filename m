From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Oct 2013 14:28:02 +0900
Subject: [PATCH] ARM: shmobile: Cosmetic update of Lager DT Reference
In-Reply-To: <CANqRtoRHyqp24QCPixxOmokcBusmru6Wx16d7jvGv8L9crctOw@mail.gmail.com>
References: <20131016215819.12718.54556.sendpatchset@w520>
 <20131017010657.GH21728@verge.net.au>
 <CANqRtoRHyqp24QCPixxOmokcBusmru6Wx16d7jvGv8L9crctOw@mail.gmail.com>
Message-ID: <20131017052801.GB30491@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 01:53:30PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Oct 17, 2013 at 10:06 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Oct 17, 2013 at 06:58:19AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Clean up the Lager DT reference board code to make it match
> >> Koelsch DT reference including using the rcar-gen2 header.
> >
> > This is getting dangerously close to churn.
> > Do you really want me to take this change?
> 
> I don't mind so much, but I think that the idea of keeping Lager and
> Koelsch in the same style makes sense. Would you prefer to split this
> up in several patches? There is some whitespace damage and also the
> header file inclusion style is different from Koelsch.

I don't think splitting it would improve my level of happiness.

I now accept that the header include change is of some merit
and I'm prepared to take the rest as baggage.
