From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Aug 2013 14:09:00 -0700
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <20130819205736.GA13964@titan.lakedaemon.net>
References: <20130819160537.1eeb0a9ebc269def138e016b@canb.auug.org.au>
 <20130819205736.GA13964@titan.lakedaemon.net>
Message-ID: <CAOesGMhRo1X=w=2-pKNz-eXiviWg3aqtVyW=f43RfigTS4dRmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it's this commit:

commit 89602312c5755c87a5ca6ba8ef6b0fce9d510951
Merge: a0cec78 f23afe2
Author:     Jason Cooper <jason@lakedaemon.net>
AuthorDate: Wed Aug 14 18:55:13 2013 +0000
Commit:     Jason Cooper <jason@lakedaemon.net>
CommitDate: Wed Aug 14 18:55:13 2013 +0000

    Merge remote-tracking branch 'arm-soc/for-next' into mvebu/drivers



You merged back the for-next branch from arm-soc into your tree. Big no-no.


This brings up the subject of subplatform trees and conflicts and
-next. I wonder if we should ask Stephen to put all these trees in a
category where if they have any substantial conflicts or weirdness
like this, that he just drops it for the current -next build instead
of spending effort on them.

That would give us on arm-soc a chance to sort out things and even
rebase patches if needed without causing a lot of extra work for sfr.


-Olof


On Mon, Aug 19, 2013 at 1:57 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Hi Stephen,
>
> On Mon, Aug 19, 2013 at 04:05:37PM +1000, Stephen Rothwell wrote:
>> Today's linux-next merge of the mvebu tree got conflicts in various files
>> between merges and commits in the arm-soc tree and merges in the mvebu
>> tree.
>
> I'm afraid I'm a bit lost...
>
>> These merges/commits in the mvebu tree appear to be from a previous
>> version of the arm-soc tree that the mvebu tree has been rebased upon.
>> Please don't do that - the arm-soc tree as a whole is not stable.
>
> I didn't do anything different from the other times I built for-next.
> Could you give me a specific example when you build linux-next again?
> I'll certainly try to avoid it in the future, but it'll be easier if I
> know what 'it' is. ;-)
>
> I'll not change for-next today, and we'll see how it goes.
>
> thx,
>
> Jason.
