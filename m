From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Nov 2012 18:29:26 +0100
Subject: [GIT PULL] at91: fixes for 3.7-rc7
In-Reply-To: <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com>
References: <50AA5ED5.8090901@atmel.com>
 <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com>
Message-ID: <50AA6C76.3000606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 05:52 PM, Olof Johansson :
> Hi Nicolas,
> 
> On Mon, Nov 19, 2012 at 8:31 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> Arnd, Olof,
>>
>> Here is another "fixes" pull request for AT91. It enables the sd/mmc driver
>> for Device Tree enabled platforms. Those patches where part of a series that
>> was split in two for reaching upstream: the MMC part is already in Linus' tree
>> and this is the arm-soc part.
>> I have placed these patches on top of the fixes that you already have for AT91.
> 
> What regressions do these fixes resolve?
> 
> It looks more like they are DT-enablement patches to me, and thus 3.8
> material, not 3.7. I'll be happy to queue them up in next/dt though.

Hi Olof,

You are right, it does not strictly fixes a regression and we were late
for including these patches which are around since end of July...
I still sent this pull-request to enable more people to use device tree
on AT91 for the upcoming release.

If you do not take it for 3.7, maybe we will have to queue these patches
on top of our AT91 pinctrl work (on Linus Walleij side), so, you do need
to queue this one for the moment...

Best regards,
-- 
Nicolas Ferre
