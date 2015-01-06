From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 16:02:30 -0600
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150106215744.GC13902@amd>
References: <20150106170433.GA5408@amd> <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd> <20150106202857.GB32308@saruman>
 <20150106205000.GB13902@amd> <20150106205413.GF32308@saruman>
 <20150106215744.GC13902@amd>
Message-ID: <20150106220230.GG32308@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 10:57:44PM +0100, Pavel Machek wrote:
> > > > > > > In 3.18, sound is nice and clear.
> > > > > > > 
> > > > > > > In 3.19, sound is unusable. It produces nasty tone when it should be
> > > > > > > quiet, and there's at least as much noise as is sound.
> > > > > > > 
> > > > > > > Unfortunately, list of mixers also changed (and there's cca 120
> > > > > > > settings), but a) it does not work with the old list and b) nothing I
> > > > > > > could figure out did make the sound usable. Some setting resulted in
> > > > > > > even more noise.
> > > > > > > 
> > > > > > > Any idea what could have caused it?
> > > > > > 
> > > > > > $ git bisect start
> > > > > > $ git bisect good v3.18
> > > > > > $ git bisect bad
> > > > > > 
> > > > > > that'll help find what caused it.
> > > > > 
> > > > > Telling someone to do hard and time consuming job that probably will
> > > > > not succeed, instead of actually providing help. Very very funny.
> > > > 
> > > > you're getting code for free, you're getting help for free. Not many
> > > > people have N900s lying around. Running a bisection is just
> > > > politeness.
> > > 
> > > Now you are speaking for yourself or for TI?
> > 
> > why bring my employer into the discussion ?
> 
> Because you are speaking of getting help for free, and I don't

are you not getting help for free ?

> remember getting any useful help from you; so I'd like to know who do

how come ? I gave you a very helpful list of commands which will direct
you at finding the root of the issue you found.

> you speak for.

for myself.

> > > Thanks for your very valuable help. I know how to do a bisection,
> > > thank you.
> > 
> > then please do it.
> 
> No, sorry, I don't think that would be reasonable use of my time at
> this point. First steps are "confirm it happens on other N900 boards,
> too", ruling out config issues at my part, and "try to get
> verification from other development boards if they have same
> problems", because most other boards are easier to work with.

you don't want to do due diligence with a bug *you* found, then there's
no way people can help you out. Sorry.

Good luck

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/ef1df610/attachment.sig>
