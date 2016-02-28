From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sun, 28 Feb 2016 20:02:02 +0530
Subject: [PATCH 00/61] gpio: Add and use devm_gpiochip_add_data()
In-Reply-To: <CACRpkdYsG8X5XiV2+Ss2GLJkFnLFzLi0uy0yy8R5sdi0b_Y+qA@mail.gmail.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>	<CACRpkdbt+RiWMA74e40MNZVnDM0t0futtFnbyu9sRhv7p93-Tg@mail.gmail.com>	<56CC1FD4.1080905@nvidia.com>	<56CC7791.2000607@nvidia.com>
 <CACRpkdYsG8X5XiV2+Ss2GLJkFnLFzLi0uy0yy8R5sdi0b_Y+qA@mail.gmail.com>
Message-ID: <56D304E2.7000608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thursday 25 February 2016 06:54 PM, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 4:15 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>> I have made the repo in git hub as
>>      https://github.com/ldewangan/linux-upstream.git
> Awesome.
>
>> branch name is devm_gpiochip.
>>      https://github.com/ldewangan/linux-upstream/tree/devm_gpiochip
> I've pulled this branch into my tree on a separate branch for
> testing. I pushed the tree to kernel.org so that the zeroday
> autobuilders can have a go at it.

Thanks you very much for taking care.

>
> If everything goes well I plan to merge this for v4.6, then we
> can merge the changes in pin control and other subsystems
> for v4.7.
Yes, once this is there, we can grep all over subsystem and push the change.

I am seeing lots of code reduction on pincontrol driver side once we 
have devm_ for pincontrol register and gpiochip_add_data().

Thanks,
Laxman
