From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Nov 2013 13:06:39 -0500
Subject: Raw notes from ARM summit.
In-Reply-To: <CACxGe6vwNv7a4h_SzyN2pgnY_2HfDLQqtw9ZsJqqba4HeQKD0A@mail.gmail.com>
References: <CACxGe6vwNv7a4h_SzyN2pgnY_2HfDLQqtw9ZsJqqba4HeQKD0A@mail.gmail.com>
Message-ID: <20131106180639.GE8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Wed, Nov 06, 2013 at 02:57:05PM +0000, Grant Likely wrote:
> I'm really close to getting a summarized report from the arm summit
> finished and posted, but it has dragged out longer than I would like.
> Therefore here are the raw notes from Etherpad. You can expect the
> report form to be published in the next 24 hours.
> 
> http://etherpad.osuosl.org/arm-ksummit-2013
> 
> The calendar:
> http://goo.gl/ifLxHl
> 
...
>  Draft policy:
> Binding must be acked by subsy maintainer
> Binding should be looked at by DT people *but* if they're 'sleepy' it
> rests with the subsys maintainer
> 
> JonathanCameron: Is it the case then that subsystem maintainers are
> welcome to say "DT people were too slow, I' ve merged that"
> Grant: yep - that's okay
> 
> LinusW: Subsystem maintainers get forced to learn about all the
> possible hardware description mechanisms to be able to review patches,
> which is a problem.
> [...]
> 
> Arnd: some people making bindings know exactly what they're doing and
> just need an Ack, some people *don't* and need more handholding
> 
> Grant: What we need to do today
> - Document policy
> - Statement on what ABI actually means: What IS ABI and what is NOT
> (What's stable and what's not)

Hmm, looks like we crossed emails.  I just sent a patch (rfc) adding a
submitting-patches.txt to devicetree/bindings/...  Maybe I got it
started before others?  Or did I duplicate effort?

thx,

Jason.
