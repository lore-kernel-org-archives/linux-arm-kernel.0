From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 07:44:59 +0200
Subject: [PATCH v3 00/26] ARM: pxa: magician: Rework HTC Magician support
In-Reply-To: <87zj09fbyq.fsf@belgarion.home>
References: <55FA4756.9080309@tul.cz> <87zj09fbyq.fsf@belgarion.home>
Message-ID: <5608D3DB.2000106@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 26.9.2015 v 17:15 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> This patchset will clean, fix, optimize and add multiple devices,
>> which can be found on the HTC Magician machine.
> ... zip ...
>>  arch/arm/mach-pxa/include/mach/magician.h |  78 +--
>>  arch/arm/mach-pxa/magician.c              | 907 +++++++++++++++++++++---------
>>  2 files changed, 682 insertions(+), 303 deletions(-)
> 
> Ok Petr, that's way better.
> This is how I see the next step :
>  1) You fix the patch 1/26 and resend only that one, it's trivial whitespacing,
>     no need to send another complete patchset

OMG my version of Kate editor differently renders the tabs depending on the font size.

> 
> Meanwhile, I'll have time to answer to patches 19 and 22. Next Sunday, I'll
> reply once more that I have queued your patches (provided that you update patch
> 1/26), and you will be able to rebase on this tree, leaving at most 2 patches to
> deal with.

It does not clearly rebase (by "fixup" during git rebase) as an another patch (#8) renames LCD GPIOs. And I have found another unnecessary tabs in patch #21. So I will send another patchset version, OK?

Petr
