From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 19 Aug 2013 17:38:33 -0400
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <CAOesGMhRo1X=w=2-pKNz-eXiviWg3aqtVyW=f43RfigTS4dRmg@mail.gmail.com>
References: <20130819160537.1eeb0a9ebc269def138e016b@canb.auug.org.au>
 <20130819205736.GA13964@titan.lakedaemon.net>
 <CAOesGMhRo1X=w=2-pKNz-eXiviWg3aqtVyW=f43RfigTS4dRmg@mail.gmail.com>
Message-ID: <20130819213833.GB13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 02:09:00PM -0700, Olof Johansson wrote:
> it's this commit:
> 
> commit 89602312c5755c87a5ca6ba8ef6b0fce9d510951
> Merge: a0cec78 f23afe2
> Author:     Jason Cooper <jason@lakedaemon.net>
> AuthorDate: Wed Aug 14 18:55:13 2013 +0000
> Commit:     Jason Cooper <jason@lakedaemon.net>
> CommitDate: Wed Aug 14 18:55:13 2013 +0000
> 
>     Merge remote-tracking branch 'arm-soc/for-next' into mvebu/drivers
> 

grmbl... Yep, that's my mistake.  I usually do a temp branch for
merge-testing against arm-soc/for-next and building.  Apparently I
forgot to make the branch first.  My apologies.

I've fixed up mvebu/drivers, and I'm build testing a rebuilt for-next
now.

> You merged back the for-next branch from arm-soc into your tree. Big no-no.

Yep, \shame/.

> This brings up the subject of subplatform trees and conflicts and
> -next. I wonder if we should ask Stephen to put all these trees in a
> category where if they have any substantial conflicts or weirdness
> like this, that he just drops it for the current -next build instead
> of spending effort on them.

Agreed.  A tree hierarchy of sorts.  mvebu and other sub-arch trees
should definitely be dropped for the day with minimal investigation.

thx,

Jason.
