From: ccross@android.com (Colin Cross)
Date: Thu, 21 Jul 2011 11:48:11 -0700
Subject: [PATCH 1/2] ARM: Tegra: Seaboard board updates for audio
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF13E@HQMAIL01.nvidia.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
	<CAOesGMjiakgvs8wcu8zRkuA9mxD5Z=S-hV3HNgqFC49pEGVADw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDF13E@HQMAIL01.nvidia.com>
Message-ID: <CAMbhsRQuzO2EW33vFGcDM+=bKLkfEY6WLn_dr7Q7o7uOekA0gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 8:37 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, July 13, 2011 5:17 PM:
>> On Wed, Jul 13, 2011 at 2:57 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> > * Initialize clock tree for audio
>> > * Add GPIO base definitions
>> > * Add audio GPIO definitions
>> > * Define platform data for WM8903 and ASoC machine driver
>> > * Add special case for Kaen to handle HP_MUTE GPIO
>> > * Register platform devices for audio
>> > * Update pinmux to cater for new GPIOs used for audio
>> >
>> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>
>> Colin, sounds like you're collecting board patches this merge window, so:
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Colin,
>
> Do you want me to ask Arnd to pick these patches up directly, or do you
> want to apply them to the Tegra for-next tree, and have Arnd pull them?

Normally I would want them to go through me so I have a chance to deal
with conflicts before it hits the arm-soc tree, but since Arnd has
already taken some patches for this release cycle, they might as well
go directly to him.
