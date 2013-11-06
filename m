From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Nov 2013 07:29:40 -0800
Subject: [PATCH] ARM: nommu: Implement dummy early_paging_init()
In-Reply-To: <20131106121000.GA6984@ulmo.nvidia.com>
References: <1382533728-19495-1-git-send-email-treding@nvidia.com>
 <CAOesGMg0Ah7HoDOiOX+dDYCA3A17-VryiULuUzT-j-BHFyCaOw@mail.gmail.com>
 <20131106121000.GA6984@ulmo.nvidia.com>
Message-ID: <CAOesGMgBQbP2ss8h+o8kFc6e=7AdFrTu9G4y8QCiVzUmSH8hzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 4:10 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Nov 05, 2013 at 11:47:13AM -0800, Olof Johansson wrote:
>> On Wed, Oct 23, 2013 at 6:08 AM, Thierry Reding
>> <thierry.reding@gmail.com> wrote:
>> > No-MMU configurations currenty fail to build because they are missing
>> > the early_paging_init() symbol.
>> >
>> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> This is still showing up on -next with at91x40_defconfig. Can you feed
>> it to the patch tracker if you haven't already?
>
> Done. I'm not sure exactly what the prerequisites are for submitting a
> patch to the tracker. The help text on the website says patches should
> be reviewed on the mailing list first and that's what I was waiting for.
> Is there some amount of time (a week or two) after which silence can be
> considered acknowledgement?

Well, I just reviewed it for you (well, acked it :-). It's always hard
to tell with a posted patch that hasn't received comments, but after a
while it's usually ok to post to the tracker.

The LAKML volume is too high to see every patch and review it. I'm
sure Russell will let you know if you get too trigger happy at sending
to the tracker too. :-)


-Olof
