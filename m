From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Dec 2012 22:52:54 +0100
Subject: [GIT] Networking
In-Reply-To: <CA+55aFwzUgxQAze=mYbEx8b61V542tzm06Df=mR1BtYVbJy0mg@mail.gmail.com>
References: <20121212.151116.143443755590581447.davem@davemloft.net>
 <CA+55aFwzUgxQAze=mYbEx8b61V542tzm06Df=mR1BtYVbJy0mg@mail.gmail.com>
Message-ID: <CAOesGMi-=4sFvbe1DGThQCe8Rd0Za1oSDvTdbbNm3iBX0AZGaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 3:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 12, 2012 at 12:11 PM, David Miller <davem@davemloft.net> wrote:
>>
>> There is one merge conflict to resolve in net/sched/cls_cgroup.c,
>> one commit changes the name of some members to "css_*" (this came
>> from Tejun's tree) and another commit adds an "attach" method.
>
> There's more than that. The ARM board mess is apparently now affecting
> the networking merges too.
>
> I fixed it up. Hopefully correctly.

Yes, it looks correct. Sorry about missing that earlier, sfr had
spotted it when it showed up in linux-next but I lost track of it.

We probably need to restructure/resort the device tree files to avoid
add/add conflicts when people just append to them all the time. I
really hope things will start to settle down churn-wise soon, as
conversions and DT enablement starts to be more complete.

(I also think we need to improve the way we handle our topics some, we
have a bit too much internal conflicts between topics in arm-soc
still, but that's a separate subject).


-Olof
