From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 08:54:57 +0100
Subject: Pending patches for s5pc110
In-Reply-To: <AANLkTimnuN9h-qka3pRlmaEsR8o6IzFgl3A2YQ5Y28HJ@mail.gmail.com>
References: <AANLkTil0wWSFHpwi58enMhhG7475uUmFoZG6QhRim6Xk@mail.gmail.com>
	<AANLkTimjwSHLiMYFywn3vHZYCbqQCCCh9qE-n3xuYOaq@mail.gmail.com>
	<20100611051521.GV7248@trinity.fluff.org>
	<AANLkTikJQnDEjVunmiCLGaVAnj5bR7JdsUZYJ9xAEdE5@mail.gmail.com>
	<20100611062300.GY7248@trinity.fluff.org>
	<AANLkTimnuN9h-qka3pRlmaEsR8o6IzFgl3A2YQ5Y28HJ@mail.gmail.com>
Message-ID: <20100611075457.GZ7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 04:07:58PM +0900, Kyungmin Park wrote:
> On Fri, Jun 11, 2010 at 3:23 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Fri, Jun 11, 2010 at 02:38:56PM +0900, Kyungmin Park wrote:
> >> On Fri, Jun 11, 2010 at 2:15 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> >> > On Fri, Jun 11, 2010 at 01:25:18PM +0900, Kyungmin Park wrote:
> >> >> Hi,
> >> >>
> >> >> No comments mean it's okay then we will prepare the patches to git pull.
> >> >
> >> > No. no comments means that people either haven't had time to sort
> >> > them out or in fact ON HOLIDAY.
> >>
> >> but you usually missed our patches frequently. with this reason our
> >> patches can't merge within proper merge window.
> >
> > I belive the last set where either being posted just-before or during
> > the last merge window. We already had far too much queueud up then and
> > we where trying to ensure that the already-queued entries where processed.
> 
> Not tell this case, please see the s5pc110 patches last year. last
> year we sent the s5pc110 related patches several times. but you don't
> give any opinions and can't accept without any reason.

I gave you comments, or at least Marke should have got them for the
series sent in November, then there's nothing in my mailbox since
then.
 
> Well it's past story,  forget it.
> 
> Last question.
> 
> I think you share the s3c maintainer-ship with Kukjin. Can you explain
> the criteria?

Ok, here's the list:

1) SystemLSI are the best placed to see all the chips in development,
   since they're the ones making them. You are only dealing with a
   subset of their output (generally the S5PC100 and S5PC110) whereas
   there are many more devices in the line.

2) SystemLSI have spent time talking to me about what they need to do
   when maintaining a system and trying to acquire the necessary skills
   for managing a port.

This does not mean that you cannot be included at a later date.

As a note, that I have left myself in the maintainers entries for the
samsung series and will re-visit this once we see how well the transfer
goes in the next kernel release or two.
 
-- 
Ben
