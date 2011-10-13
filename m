From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Oct 2011 16:42:43 -0700
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A08D@HQMAIL01.nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
	<20111012224131.GD25128@quad.lixom.net>
	<CACxGe6tf0Ly8AC-6xUeoMrVj3y0KHkrcgj87SerAaCAnNhfNqA@mail.gmail.com>
	<20111012231910.GA13960@quad.lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A08D@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhEL7qgUGP_t_rAueqUndhv=rBPG2eeQBffpfrri_nj4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 9:36 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, October 12, 2011 5:19 PM:
>> On Wed, Oct 12, 2011 at 05:03:24PM -0600, Grant Likely wrote:
>> > On Wed, Oct 12, 2011 at 4:41 PM, Olof Johansson <olof@lixom.net> wrote:
>> > > On Tue, Oct 11, 2011 at 04:16:14PM -0600, Stephen Warren wrote:
> ...
>> > > Otherwise, patch looks good. Due to dependencies between this, the rest
>> > > of this patch series and the pinmux changes, I'll hold off on it until
>> > > the dependencies land (i.e. target it for 3.3). We're cutting it very close
>> > > to the merge window as it is, I'll start for-3.3 branches shortly.
>> >
>> > Actually, see if you can get it in via the same tree as the pinmux
>> > changes. ?Dependencies is not a reason to hold off from getting it
>> > into linux-next.
>>
>> Ok, the fixup is minimal, should be trivial to spot at git merge time.
>>
>> Stephen, do you want to respin yourself or should I do the __devinit
>> change when I apply?
>
> I'm happy for you to fix that up when you apply if you're happy doing that.
>
> The same fixup applies to the pinmux patches too.

Thanks, applied (and pinmux patch fixed up). for-3.2/features was
rebased to roll in the pinmux change.


-Olof
