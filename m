From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Jul 2011 13:07:14 -0700
Subject: [PATCH 1/2] ARM: Tegra: Seaboard board updates for audio
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF249@HQMAIL01.nvidia.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
	<CAOesGMjiakgvs8wcu8zRkuA9mxD5Z=S-hV3HNgqFC49pEGVADw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDF13E@HQMAIL01.nvidia.com>
	<CAMbhsRQuzO2EW33vFGcDM+=bKLkfEY6WLn_dr7Q7o7uOekA0gA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDF249@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMjsvpkxi27aA-fi9_DfrKY8GcruNxFEbLT4HU5Om5bDiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 12:57 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Colin Cross wrote at Thursday, July 21, 2011 12:48 PM:
>> On Thu, Jul 21, 2011 at 8:37 AM, Stephen Warren <swarren@nvidia.com> wrote:
> ...
>> > Colin,
>> >
>> > Do you want me to ask Arnd to pick these patches up directly, or do you
>> > want to apply them to the Tegra for-next tree, and have Arnd pull them?
>>
>> Normally I would want them to go through me so I have a chance to deal
>> with conflicts before it hits the arm-soc tree, but since Arnd has
>> already taken some patches for this release cycle, they might as well
>> go directly to him.
>
> Arnd,
>
> Per Colin's note above, can you please pick up the patches below into
> arm-soc.git. Let me know if you need me to repost them so you have a
> good copy. These are probably appropriate for your tegra/devel branch,
> although they're actually based on a merge of linux-next and Tegra's
> for-next from a week ago.
>
> Both Acked-by Olof already:
>
> [PATCH 1/2] ARM: Tegra: Seaboard board updates for audio
> http://www.spinics.net/lists/arm-kernel/msg133180.html
>
> [PATCH 2/2] ARM: Tegra: Seaboard: Add USB devices
> http://www.spinics.net/lists/arm-kernel/msg133181.html
>
> Not yet Acked-by anyone (Colin, Olof, could you please oblige; thanks):
>
> [PATCH 2/2] ARM: Tegra: Harmony: Add USB device
> http://www.spinics.net/lists/arm-kernel/msg133175.html
> (don't pick up patch 1 of this series; there's discussion on how to handle
> that better)

I didn't see a need to ack a patch that had my earlier S-o-B on, but
feel free to add one, Arnd.


-Olof
