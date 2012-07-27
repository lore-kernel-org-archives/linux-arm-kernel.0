From: ccross@android.com (Colin Cross)
Date: Thu, 26 Jul 2012 23:44:10 -0700
Subject: [GIT PULL] OMAP4 coupled CPUidle support for v3.6
In-Reply-To: <CAMQu2gynmXqprXPctYHA-V6niE4QptJ_fQ8Fv7J5OAooK1A6wQ@mail.gmail.com>
References: <87394enqz8.fsf@ti.com>
 <CAOesGMiTfW6Qz=z4FvG=SomCuKo3C8um1M=uXJV8ZAjeKhRoOg@mail.gmail.com>
 <CAMQu2gynmXqprXPctYHA-V6niE4QptJ_fQ8Fv7J5OAooK1A6wQ@mail.gmail.com>
Message-ID: <CAMbhsRSdWpsYub+M9Li44cW1dc2wg76Q3njAxNK2vjC0_jOeJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:34 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Jul 27, 2012 at 2:19 AM, Olof Johansson <olof@lixom.net> wrote:
>> Kevin,
>>
>> On Thu, Jul 26, 2012 at 2:37 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Hi Arnd, Olof,
>>>
>>> I know it is late, but I'm really hoping this can still make it for
>>> v3.6, so consider this a [GIT PLEA].  ;)
>>
>> New features submitted halfway through the merge window? Yeah, that's late.
>>
>> I'll pull it in as late2/pm once the below is fixed, but I won't
>> promise we'll send it up.
>>
>>
>>> Kevin Hilman (1):
>>>       ARM: OMAP4: CPUidle: add synchronization for coupled idle states
>>>
>>> Santosh Shilimkar (3):
>>>       ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
>>>       ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
>>>       ARM: OMAP4: CPUidle: Open broadcast clock-event device.
>>
>> This looks odd, Colin was author to the first of the commits
>> attributed to Santosh.
>>
> Not sure what you mean. These patches are written by me. Kevin, Collin helped
> in review. If you are referring to the {ARM: OMAP: timer: allow gp
> timer clock-event to be
> used on both cpus} which does have SOB from me and Colin. The very first version
> of this version I picked was from product tree in which it was
> commited on Coiln's name.
> Later I updated that forf the multi-omap and the new timer code and
> hence the update
> in Author.

I have no problem with the authorship on these two patches.
