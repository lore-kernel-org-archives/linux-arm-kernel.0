From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2011 20:01:11 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
In-Reply-To: <20111207105913.GA23720@arm.com>
References: <20111206152955.GC31720@arm.com>
 <20111206203416.GV14542@n2100.arm.linux.org.uk>
 <CAHkRjk6ATr1thCL+-Cb4bOiObVmXrcoqvBiEBVzss_dATjt1VA@mail.gmail.com>
 <20111206231630.GY14542@n2100.arm.linux.org.uk>
 <20111207105913.GA23720@arm.com>
Message-ID: <20111207200111.GC14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 10:59:13AM +0000, Catalin Marinas wrote:
> On Tue, Dec 06, 2011 at 11:16:30PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 06, 2011 at 10:24:28PM +0000, Catalin Marinas wrote:
> > > On 6 December 2011 20:34, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > As I said, I will merge it this time around, but next time I won't.
> > > 
> > > As I also said above, there are solutions. What it is really needed is
> > > _better_ collaboration during merges and _discussing_ the best
> > > approach rather than threatening that there won't be other pulls.
> > 
> > And what about the email from Philippe on me rejecting your first pull
> > request?  There is no need to try to exert commercial pressures when the
> > problems are legal and technical.
> 
> I'm not discussing Philippe's email publicly (as it was in private).
> 
> >From my perspective, the tone of your email suggested more of a good
> opportunity not to merge LPAE (and in subsequent emails doing ARM a
> great favour by only accepting it this time) rather than a more
> constructive 'fix this before merging'.

For fuck sake Catalin - which bit of "I MERGED IT AND THEN I HAD TO
THROW IT OUT" do you not understand?

I said precisely what needed to be said.  You fucked up because you
didn't follow the DCO.  Plain and simple.  And I had to throw it out
of an already published devel-stable branch which had been published
for 9+ hours.  Of course I'd be annoyed by that - that mistake means
I *HAD* to break the promise I made to the rest of the community that
I would never rewind the devel-stable branch, ever.

For someone who has been working on the kernel for a great number of
years, you show quite a lack of understanding of community process
when you slip up like that, and _then_ have the audacity to say that
it's a 'minor issue' (your words not mine.)

> Since you mentioned commercial pressures, yes, there are many, but I'm
> not sure you are aware of all of them (many companies haven't publicly
> announced their plans, though they have very aggressive targets). I am
> asked on a weekly basis when features like LPAE (or other bug-fixes -
> TLBs, ASIDs) get into mainline. I can't really answer as it does not
> depend on me and I don't have any visibility on when it would happen.
> Long delays is not a problem, it's predictability that matters. As a
> temporary (can be 1-2 years) workaround, I have to recommend them to use
> one of my development trees (e.g. linux-arm-arch).

None of that should _ever_ be used as any kind of motivation to get
something into mainline if it's not ready to be there.  Clearly, from
the issues raised with your tree thus far it wasn't actually ready.

Ready does not mean "it builds for me".  Ready means it builds, it's
tested, it's got proper commit messages, attributations and sign-offs.
If it's not at that stage, then quite simply it is not ready.  There's
no two ways about that.

And as I've already explained to you several times now, since sign-offs
are seen by many to be a legal statement, incorrect sign-offs are not
a minor problem.  Had it been correct, I would not have had to throw it
out of my tree.

So please, get it through your head that _had_ the sign-offs been correct
we wouldn't be having this discussion and your tree wouldn't have been
thrown out - and it would've actually been merged _before_ Will's idmap
changes.
