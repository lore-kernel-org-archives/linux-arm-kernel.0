From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Tue, 7 Apr 2015 16:14:20 +0800
Subject: [GIT PULL] Support for Fujitsu MB86S7X SoCs
In-Reply-To: <20150402005029.GH8137@localhost>
References: <CAKR0VNJdCEEoM8mqFrc-teQ-q=DopGisos16+uKt=ky2mRjF8g@mail.gmail.com>
 <20150402005029.GH8137@localhost>
Message-ID: <CAKR0VNKg6MuqjTqU-ExV5g_HAadEZNasNH0wGFj5_Wee6T-esg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-02 8:50 GMT+08:00 Olof Johansson <olof@lixom.net>:
> Hi Vincent,
>
> On Wed, Mar 18, 2015 at 02:44:30PM +0900, Vincent Yang wrote:
>> Hi Arnd and Olof,
>>
>> Please consider pulling in these patches for series of Fujitsu SoC
>> based around variations of 2xCA7+2xCA15 big.LITTLE architecture.
>>
>> The MHU driver is already queued in Mailbox tree.
>>
>> Thanks,
>>
>> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
>>
>>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.linaro.org/landing-teams/working/fujitsu/integration.git
>> s7x-arch-pull
>>
>> for you to fetch changes up to 9cf417fee0bbea9296791fa9a15ab289307bb26a:
>>
>>   ARM: MB86S7x: Add configs (2015-03-17 11:22:40 +0530)
>
> Please use signed tags when you send pull requests (and ideally, please get
> your GPG key signed by people at the next Linaro Connect or other event where
> you will get in contact with other kernel developers).
>
> I started looking at this patch set, and it's adding global include file
> contents for things that should only exist under the drivers/soc/ directory,
> i.e. internal driver defines, etc -- it shouldn't be exposed to the kernel as
> a whole.
>
> I'll find the individual patches where they were posted and comment on those
> directly.
>
> As far as applying the code -- initial platforms like these usually go in
> through different branches so applying them directly makes sense for us. Once
> you're up and rolling as a maintainer you'll get a hang of what we want to see
> grouped in the different branches and pull requests will be easier to handle.

Thanks a lot for your review and guidance!
We look forward to your comments.

Kind regards
Vincent

>
>
> Thanks,
>
> -Olof
