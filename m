From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Mar 2012 18:18:40 -0700
Subject: [GIT PULL] ARM: Two more fixes for merge window fallout
In-Reply-To: <CA+55aFzeN+m0mWqe6ajBB=cdTNJMF2FgW17_mm_n0BoKokQVRw@mail.gmail.com>
References: <CAOesGMjU5tehTf7+nYQv1_7a=+gGN2hVYUdh1g_BF=WRYj0hgg@mail.gmail.com>
 <CA+55aFzeN+m0mWqe6ajBB=cdTNJMF2FgW17_mm_n0BoKokQVRw@mail.gmail.com>
Message-ID: <CAOesGMhrokqQajQ6RROXdWNvVUd3WNjO4i3qggGAVXo5h05TKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 5:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 30, 2012 at 4:20 PM, Olof Johansson <olof@lixom.net> wrote:
>>
>> are available in the git repository at:
>>
>> ?git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes
>
> Hmm. I *think* you meant to ask me to pull the "fixes-for-linus" tag,
> which points at the same commit as the "fixes" branch. No?

Yes, that's correct.

> You might want to double-check whatever script or workflow you use to
> generate these pull requests.

Hmm, I had 'fixes' checked out locally, and used regular git request-pull.

Oh! I know what it was. I pushed the branch before I pushed the tag,
so when I generated the request the branch had propagated out from ra
to git.kernel.org but not the tag.

Since the branch matched but no tag did, request-pull used it and took
the local tag contents for the message so I didn't notice the
difference.

Thanks for the sanity check, I'll double-check in the future.


-Olof
