From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Jan 2017 12:32:54 +0100
Subject: [PATCH v5 1/2] ARM: dts: at91: add devicetree for the Axentia
 TSE-850
In-Reply-To: <81d5b553-38db-5137-2eac-145cb2f76578@axentia.se>
References: <1484035732-31635-1-git-send-email-peda@axentia.se>
 <1484035732-31635-2-git-send-email-peda@axentia.se>
 <20170110092928.hwd4l4k3eyagepco@piout.net>
 <b686fa42-bbfb-dec2-460f-ef00869bc12e@axentia.se>
 <20170110104248.iscurq55d7n26gfd@piout.net>
 <81d5b553-38db-5137-2eac-145cb2f76578@axentia.se>
Message-ID: <20170110113254.fusg25ilvekqll5f@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2017 at 12:21:42 +0100, Peter Rosin wrote :
> On 2017-01-10 11:42, Alexandre Belloni wrote:
> > On 10/01/2017 at 10:52:56 +0100, Peter Rosin wrote :
> >> On 2017-01-10 10:29, Alexandre Belloni wrote:
> >>> Hi,
> >>>
> >>> This needs a commit message, please add one.
> >>
> >> There's not all that much to say, but ok, I'll add something.
> >>
> > 
> > It doesn't have to be long but it has to be present.
> 
> Does it really? There are quite a few examples to contradict that,
> and checkpatch doesn't complain. That's no proof of course...
> 
> As I said, I'll add something.
> 

There is public shaming for maintainers taking patches without a commit
message, that's enough for me to require a commit message ;)

https://lwn.net/Articles/560392/

> >>> On 10/01/2017 at 09:08:51 +0100, Peter Rosin wrote :
> >> There's also the benefit of the increased chances of me getting
> >> notified of changes. I don't mind...
> >>
> > 
> > Do you expect changes coming from third parties? I'm fine with it
> > anyway.
> 
> Ok, I'll remember this and blame you for everything :-)
> 

Well, you can let it there, I was just not sure whether you were
expecting to see patches or just trying to make checkpatch happy. As
said, I'm fine with it.

> >>>> +&main {
> >>>> +	clock-frequency = <12000000>;
> >>>> +};
> >>>> +
> >>>
> >>> I don't think this is needed
> >>>
> >>>
> >>
> >> "this"? The &main frequency, or all of them?
> >>
> > 
> > I meant just main
> 
> Ok, I'll test with that change and then resend. Thanks!
> 
> Cheers,
> peda

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
