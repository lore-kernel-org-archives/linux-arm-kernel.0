From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 8 Apr 2014 23:12:02 +0900
Subject: [PATCH v2 0/2] Add PCI USB DT support for R8A7790/Lager reference
 board
In-Reply-To: <53440346.7020703@cogentembedded.com>
References: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
 <CANqRtoSg+JLZ5AbiOnnfXjg3m86q5J2U675VhgmhP1jxmDmmLA@mail.gmail.com>
 <53440346.7020703@cogentembedded.com>
Message-ID: <CANqRtoSFac-cQXYtfB218fXp1pa0yof4P+J2r=0OSK=RqvFm6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Apr 8, 2014 at 11:10 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 04/08/2014 05:59 PM, Magnus Damm wrote:
>
>>>     Here's the set of 2 patches against Simon Horman's 'renesas.git'
>>> repo,
>>> 'renesas-devel-v3.14-20140403' tag. Here we add the PCI USB device tree
>>> support on the R8A7790/Lager reference board. The patchset requires the
>>> 'pci-rcar-gen2' driver device tree support (just re-posted) in order to
>>> work.
>
>
>>> [1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
>>> [2/2] ARM: shmobile: lager: enable internal PCI
>
>
>> Thanks for your efforts. It is good to see that you are caring for
>> both r8a7790 and r8a7791 now.
>
>
>> By the way, have you decided how to use DT with the PHY driver? Just
>> integrating this portion seems of the hardware seems insufficient to
>> me.
>
>
>    Yes, I have written the new driver for the generic PHY framework,
> supporting DT probing. I'm going to post it today -- I lacked the time to
> post all at once.
>    This new driver (and some additional patches) provides for doing what
> you've indicated to be the desirable behavior, i.e. configuring the PHY's
> UGCTRL2 register depending on what kind of USB driver gets loaded. I hope
> you will be able to use my patches for your further work on USB DT support.

Thanks, that's very nice to hear. I'm looking forward to see how the
pieces fit together!

Cheers,

/ magnus
