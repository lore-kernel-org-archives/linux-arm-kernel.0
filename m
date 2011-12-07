From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Dec 2011 10:59:13 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
In-Reply-To: <20111206231630.GY14542@n2100.arm.linux.org.uk>
References: <20111206152955.GC31720@arm.com>
 <20111206203416.GV14542@n2100.arm.linux.org.uk>
 <CAHkRjk6ATr1thCL+-Cb4bOiObVmXrcoqvBiEBVzss_dATjt1VA@mail.gmail.com>
 <20111206231630.GY14542@n2100.arm.linux.org.uk>
Message-ID: <20111207105913.GA23720@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:16:30PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 06, 2011 at 10:24:28PM +0000, Catalin Marinas wrote:
> > On 6 December 2011 20:34, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > As I said, I will merge it this time around, but next time I won't.
> > 
> > As I also said above, there are solutions. What it is really needed is
> > _better_ collaboration during merges and _discussing_ the best
> > approach rather than threatening that there won't be other pulls.
> 
> And what about the email from Philippe on me rejecting your first pull
> request?  There is no need to try to exert commercial pressures when the
> problems are legal and technical.

I'm not discussing Philippe's email publicly (as it was in private).

>From my perspective, the tone of your email suggested more of a good
opportunity not to merge LPAE (and in subsequent emails doing ARM a
great favour by only accepting it this time) rather than a more
constructive 'fix this before merging'.

Since you mentioned commercial pressures, yes, there are many, but I'm
not sure you are aware of all of them (many companies haven't publicly
announced their plans, though they have very aggressive targets). I am
asked on a weekly basis when features like LPAE (or other bug-fixes -
TLBs, ASIDs) get into mainline. I can't really answer as it does not
depend on me and I don't have any visibility on when it would happen.
Long delays is not a problem, it's predictability that matters. As a
temporary (can be 1-2 years) workaround, I have to recommend them to use
one of my development trees (e.g. linux-arm-arch).

On the positive side, more and more companies rely on the mainline
kernel and many of them don't even trust a set of patches unless it's in
the mainline kernel. The Linux community complained in the past that
companies forked the kernel and used old versions but now we should
really help those that want to stay up to date with the latest mainline.

-- 
Catalin
