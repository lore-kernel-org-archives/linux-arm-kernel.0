From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 23 Feb 2016 20:45:29 +0530
Subject: [PATCH 00/61] gpio: Add and use devm_gpiochip_add_data()
In-Reply-To: <56CC1FD4.1080905@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdbt+RiWMA74e40MNZVnDM0t0futtFnbyu9sRhv7p93-Tg@mail.gmail.com>
 <56CC1FD4.1080905@nvidia.com>
Message-ID: <56CC7791.2000607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Linus,

On Tuesday 23 February 2016 02:31 PM, Laxman Dewangan wrote:
>
> On Monday 22 February 2016 08:14 PM, Linus Walleij wrote:
>> On Mon, Feb 22, 2016 at 3:07 PM, Laxman Dewangan 
>> <ldewangan@nvidia.com> wrote:
>>
>>> Add resource management APIs for gpiochip_add_data() and
>>> gpiochip_remove() and use these APIs from different HW drivers.
>>>
>>> This is based on discussion on patch to use the new APIs.
>>>          gpio: Add devm_ apis for gpio_chip_add and remove
>> Awesome!
>>
>> Do you have a git I can just pull these off so I don't have to apply
>> then all one-by-one?
>
>
> Nop, I do not have the git repo for sharing as of now at this time.
> Trying to learn to how to create.
>


I have made the repo in git hub as
     https://github.com/ldewangan/linux-upstream.git

branch name is devm_gpiochip.
     https://github.com/ldewangan/linux-upstream/tree/devm_gpiochip

I am not sure that it will work or not but I have pushed all changes to 
this repo/branch.
This is on top of your repo
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
          branch gpio-fornext

I collected acked by and also added in patch.



Thanks,
Laxman
