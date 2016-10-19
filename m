From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 10:15:49 +0100
Subject: [PATCH v2 0/8] crypto: ARM/arm64 - big endian fixes
In-Reply-To: <CAKv+Gu_A1XOL=yST_isyvMZL=9wUcuiFXdfmOqw7PO5te24Ktw@mail.gmail.com>
References: <1476209720-21114-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161018114932.GG10115@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9wuXnrq77a3Zk0GnHgnkpURh=EegwgP+vAwMC=rdm3qA@mail.gmail.com>
 <20161019030333.GA1269@gondor.apana.org.au>
 <20161019084607.GB9193@arm.com>
 <CAKv+Gu_A1XOL=yST_isyvMZL=9wUcuiFXdfmOqw7PO5te24Ktw@mail.gmail.com>
Message-ID: <20161019091549.GF9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 09:49:46AM +0100, Ard Biesheuvel wrote:
> On 19 October 2016 at 09:46, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Oct 19, 2016 at 11:03:33AM +0800, Herbert Xu wrote:
> >> I was planning merging these for 4.10.  But I'm fine with them
> >> going through the arm tree.  Let me know what you guys want to
> >> do.
> >
> > I assumed you'd take them through crypto, as per usual, so I didn't
> > queue anything in the arm64 tree.
> >
> > Ard -- were you planning to get these in for 4.9?
> >
> 
> These are arguably bug fixes, but I spotted them by accident, they
> weren't reported to me or anything. But it seems strange to add a cc
> stable and then hold off until the next merge window.
> 
> In any case, I don't care deeply either way, as long as they get
> merged in the end. I think it makes sense to keep them together (arm64
> + ARM), so Herbert's tree is a more natural route for them to take. I
> will leave it up to Herbert whether they are sent onward as fixes or
> as part of v4.10

Sounds good to me.

Will
