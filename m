From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2016 11:00:34 -0800
Subject: linux-next: manual merge of the watchdog tree with the arm-soc
 tree
In-Reply-To: <56DD71D6.8040406@arm.com>
References: <20160307150402.191ba735@canb.auug.org.au>
 <CAOesGMjD51rNqd3V8BE6xHkYZQdB8nc_Azppk1U+m8GwrtUv6w@mail.gmail.com>
 <56DD71D6.8040406@arm.com>
Message-ID: <CAOesGMjrE3g0LBt_bJz8MZFS3REH1G5jC=Jv51V2upJXJo2VYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 4:19 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Olof,
>
> On 07/03/16 05:41, Olof Johansson wrote:
>>
>> Hi Wim,
>>
>> It's much easier for us if all DTS changes go in through the arm-soc
>> trees, to avoid these kind of conflicts. Is this on a branch where you
>> can easily drop it and we pick it up instead, or is it on a now-stable
>> branch?
>>
>
> Sorry for that. Since the patch series was still under discussion and
> v14 was posted 3 days ago, I had not checked with Fu Wei on his plans
> for DTS changes.
>
> Let me know if you want to pick up this single patch directly or want me
> to send PR for that if Wim drops it from his branch. I might have couple
> of DTS warning fixes for juno/vexpress(though I need to wait for Rob's
> acks to them), so I can bundle them together.

We're short on time for -rc7, most material should have been in by
now. So you might want to send this separately if you think Rob will
time out.

I'm OK with either applying directly or you bundling with other 64-bit
DTS material. Either way, send to arm at kernel.org and we'll pick it up
from there.


Thanks,


-Olof
