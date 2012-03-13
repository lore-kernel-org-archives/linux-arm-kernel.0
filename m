From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 12 Mar 2012 20:50:14 -0500
Subject: linux-next: manual merge of the cpuidle-cons tree with the
 arm-soc tree
In-Reply-To: <20120313100625.b500f0efb546a9f4ceeb12ba@canb.auug.org.au>
References: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
 <4F5E1ECC.1040605@atmel.com>
 <CAMXH7KH_vgri3EPRvkXR+LddRUc=0ve=4u7yr51utBfgV5bF3w@mail.gmail.com>
 <20120313100625.b500f0efb546a9f4ceeb12ba@canb.auug.org.au>
Message-ID: <CAMXH7KFw703n3UyXFj0cGZ_scpvHR8c+iguuUQPuEQgfswnaRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 6:06 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Rob,
>
> On Mon, 12 Mar 2012 12:03:48 -0500 Rob Lee <rob.lee@linaro.org> wrote:
>>
>> On Mon, Mar 12, 2012 at 11:05 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA1
>> >
>> > On 03/09/2012 08:37 AM, Stephen Rothwell :
>> >>
>> >> Today's linux-next merge of the cpuidle-cons tree got a conflict
>> >> in arch/arm/mach-at91/cpuidle.c between commit 00482a4078f4 ("ARM:
>> >> at91: implement the standby function for pm/cpuidle") from the
>> >> arm-soc tree and commit 7a1f6e72dce1 ("ARM: at91: Consolidate time
>> >> keeping and irq enable") from the cpuidle-cons tree.
>> >>
>> >> I fixed it up (I think - see below) and can carry the fix as
>> >> necessary.
>> >
>> > Yes: resolution correct. Please carry it.
>>
>> Who should carry this fixup and related necessary at91 changes? ?Me?
>> FYI, my at91 changes are dependent on my core cpuidle change, but my
>> core cpuidle changes do not require any at91 changes as the at91 and
>> other platform changes were only made to consolidate duplicate code.
>
> I will carry the fixup and Linus will presumably do the same fix when he
> merges these trees in his tree. ?I am not sure what you mean by "related
> at91 changes".
>

Thanks Stephen.  By "related changes" I just meant that if I were to
make a branch to carry the fixup, I'd need to all merge in the at91
related changes that are on linux-next but not on an rc tag yet.  But
please ignore this statement if it doesn't make sense.  I'm not yet
knowledgeable on the workflow once submitted patchsets reach this
level.

> --
> Cheers,
> Stephen Rothwell ? ? ? ? ? ? ? ? ? ?sfr at canb.auug.org.au
