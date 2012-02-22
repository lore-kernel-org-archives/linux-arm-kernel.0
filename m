From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 23 Feb 2012 04:13:26 +0530
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <20120222193526.GC7041@n2100.arm.linux.org.uk>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
 <CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>
 <00f401ccf0f8$0db84ec0$2928ec40$%kim@samsung.com>
 <CABb+yY0j0j7Qw4MCwP_F+DKzmpdmZ3x0QC2Ktj2qmGnL=Ocx0Q@mail.gmail.com>
 <011c01ccf107$5624d020$026e7060$%kim@samsung.com>
 <CABb+yY1aeZ9=2GiHni3bZuRjW66Mxz7K0M753Lc-6UdxaVpBzA@mail.gmail.com>
 <1329906421.24656.93.camel@vkoul-udesk3>
 <4F451D24.1040009@samsung.com>
 <CABb+yY0Zy3Xx4OZTobo2y-J4NXokGCV47PdPyKs+aOnqtng7pQ@mail.gmail.com>
 <20120222193526.GC7041@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY2rhyRC=srq+4eKc5g_Yne0o3yqX0hV9wxH3NqohbFqHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 1:05 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

Just in case you didn't read the ugly thread fully, let me clarify a few points.

> That, to me, means that Samsung hold the copyrights, and Jaswinder Singh
> was the author of it.  Jaswinder has no copyright on the code.
Exactly what I've been saying.


> Note that Boojin has contributed more lines of code than Javi.
>
More lines of code, yes. Note 0 contribution to the engine of pl330.
OTOH seeing the intricate fixes that Javi submitted to the core,
is impressive. Being the author of code, I sense Javi
has far better understanding of PL330 and the driver.


> What would be fair is to add the first _two_ lines indicating that
> Samsung maintains the copyright to 2012.
>
OK, but that may not be scalable considering next year too someone
could want to update the copyright to 2013 and so on.
So I suggested simply change 2010 to 2010-2012 in the existing notice.


> However, it would *not* be unreasonable to add Boojin Kim to
> drivers/dma/pl330.c as a separate patch _before_ or _after_ this patch,
> and I think that would be more warranted than adding Javi Merino as an
> author based on the above stats.
>
Based on the LOC stats, maybe. But not on the quality of patches.
I say let's add Javi and Boojin both.


>> Kukjin thinks merging two files is a serious enough change to
>> warrant co-authorship, which I disagree.
>
> Get a clue.  Reading the patch.  Kukjin isn't claiming co-authorship.
> Boojin is.  Different person.
>
I meant Kukjin is defending co-ownership of Boojin on the basis of this merge.


>> I am equally pissed off by the fact that Kukjin/Boojin sneaked in the
>> co-authorship in this revision while carrying over the Acked-by's from
>> previous revision as if it has already been approved by others.
>
>Go and check the file history, and you'll see it's justified.
>
Actually I know more than the history of file. I have worked with Boojin.

> Rubbish.  It does make sense, because it's saying where the changes
> came from.  That's done quite often when moving code around.
>
> You could say that moving code from file A to file B and commenting
> that it came from file A makes no sense because the code is no longer
> in file A.  Well, that's definitely the case, but that doesn't mean
> you don't credit where it came from in the first place.
>
Btw _every_ file involved in the merger is authored by me, so we are not
at the risk of wiping out credit log of someone's contribution.
Anyways, I think I can live with that piece of history stuck to the
file forever.
