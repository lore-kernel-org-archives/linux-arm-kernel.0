From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 22:18:51 -0700
Subject: [GIT PULL 1/3] ARM: mvebu: cleanup for v3.11 #4
In-Reply-To: <20130615034023.GK31667@titan.lakedaemon.net>
References: <20130613212137.GE31667@titan.lakedaemon.net>
 <20130614220555.GH17326@quad.lixom.net>
 <20130615034023.GK31667@titan.lakedaemon.net>
Message-ID: <CAOesGMjQmJuPp1mrFqPiNFJVyF3c14Xo+=b-F=OTMn+K83FkEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 8:40 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Jun 14, 2013 at 03:05:55PM -0700, Olof Johansson wrote:
>> On Thu, Jun 13, 2013 at 05:21:37PM -0400, Jason Cooper wrote:
>> > The following changes since commit c589f9b4b51317cfc530812fe90a9895bd51430e:
>> >
>> >   arm: mvebu: mark functions of armada-370-xp.c as static (2013-05-21 13:44:32 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-4
>>
>> Pulled. I was this >< close to just cherry-picking the patch though, since
>> that's way more efficient for just a single patch. But that'd mess up your
>> downstream users.
>
> Thanks for not doing that.  I admit I hadn't considered this situation
> when I put together this workflow.  Having mvebu stuff in linux-next
> definitely prevents cherry-picking like above.
>
> For the next window (things seems pretty calm in mvebu-land right now!)
> I'll back off on the PRs for normal branches to avoid
> commit/merge-tag/commit/merge-tag on your side.
>
> Is there any other reason you might need to cherry-pick something in my
> tree?  I can't think of one, and would prefer to keep doing linux-next
> if possible.


Main reason for cherry-picking was just to save a few steps. I had
been doing git fetch / tig [for review] / git branch / git merge / git
merge / vi / git commit    for a few hours and was looking for ways to
avoid single-patch branch pulls.


But yeah, once you're in linux-next, it's game over. Which is the
downside of having your tree there. But there's upside to it too.


-Olof
