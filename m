From: tytso@google.com (Theodore Tso)
Date: Wed, 3 Mar 2010 14:22:37 -0500
Subject: board/device file names, and machine names
In-Reply-To: <5fca72811003031108n6d4799cbmf9254ab5d9df69d8@mail.gmail.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
	<5fca72811003031108n6d4799cbmf9254ab5d9df69d8@mail.gmail.com>
Message-ID: <5fca72811003031122r21402133n4ec36193926f51d1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying again in plain text to avoid the
HTML-means-mail-is-automatically-SPAM filter.

-- Ted

On Wed, Mar 3, 2010 at 2:08 PM, Theodore Tso <tytso@google.com> wrote:
> On Tue, Mar 2, 2010 at 5:56 PM, Brian Swetland <swetland@google.com> wrote:
>>
>>
>> We would, of course, prefer to keep the board named mahimahi for all
>> the reasons that have been mentioned in various previous discussions
>> around trout, etc:
>> 1. This was the name used during development for the platform.
>> 2. This is the name the bootloader uses and the production bootloader
>> passes module parameters, etc under this name
>
> This to me is the biggest thing to get right --- if there is deployed
> userspace which is using this name (mahimahi) in the bootloader to boot the
> machine, then changing this means that it adds a barrier to users who want
> to use the standard device userland, but who want to try testing their own
> kernel built from mainline.?? Assuming that we eventually solve the rest of
> the issues, it would be a darned shame that just because the upstream
> community wanted to be "helpful" in renaming the device, someone wanting to
> build from upstream sources has a to apply a patch reversing the rename so
> that it will actually *work* on a standard Nexus One....
>
> -- Ted
>
>
>
