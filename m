From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 2 Oct 2018 13:09:08 +0200
Subject: [GIT PULL] ARM: defconfig update for v4.20
In-Reply-To: <CAK8P3a1jtA77tunDWEjqAvYgNac-EFVdg07Va6neya4r2HSdQQ@mail.gmail.com>
References: <8bb0af1d-8323-9833-ee1c-bbbb9d65a686@gmail.com>
 <CAK8P3a1jtA77tunDWEjqAvYgNac-EFVdg07Va6neya4r2HSdQQ@mail.gmail.com>
Message-ID: <0e713ca2-b8e4-dbf1-8160-f8e40ab21558@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/10/2018 18:06, Arnd Bergmann wrote:
> On Sat, Sep 29, 2018 at 5:16 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> 
>>
>> for you to fetch changes up to f718739d1c219decf2e4e4f0121753439850e5ab:
>>
>>   ARM: defconfig: add mediatek_v7_defconfig (2018-09-25 16:18:15 +0200)
>>
>> ----------------------------------------------------------------
>> - add arm32 defconfig for mediatek SoCs.
> 
> You probably don't want CONFIG_DEBUG_LL=y, or CONFIG_COMPILE_TEST=y
> in there. Please review the file for additional options that might be incorrect.
> 

Correct. Apart I just realized that it only enabled mt7623 and leaves alone the
other armv7 mediatek SoCs. So there is more work to be done here.

I propose you drop the merge request for this release.

Sorry for the inconvenience.

Matthias
