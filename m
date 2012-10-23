From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 23 Oct 2012 21:23:03 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
Message-ID: <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 22 Oct 2012, Jean Pihet wrote:
>
>> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>>
>> > Do you have CPU_IDLE enabled?
>> FYI the issue is not present with CPU_IDLE enabled.
>
> Hmm, how can you tell?  I thought you weren't able to reproduce it with
> CPU_IDLE disabled either?
I could not reproduce the issue, with and without CPU_IDLE enabled.
What puzzles me is that the PM QoS code only has influence on the
states chosen by cpuidle, so the change should not have any impact
with CPU_IDLE enabled. I reallt need to reproduce the issue.
Let me try with the same setup as yours (bootloader images,
omap2pus_defconfig, angstrom roots).

Regards,
Jean

>
>
> - Paul
