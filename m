From: swetland@google.com (Brian Swetland)
Date: Tue, 2 Mar 2010 17:01:11 -0800
Subject: board/device file names, and machine names
In-Reply-To: <1267577534.8759.168.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<20100302235137.GC29715@n2100.arm.linux.org.uk>
	<1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
	<4B8DB1A1.2060305@am.sony.com>
	<1267577534.8759.168.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <a55d774e1003021701r2dcadca2q395eba41f788af0f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 2, 2010 at 4:52 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Tue, 2010-03-02 at 16:47 -0800, Tim Bird wrote:
>> On 03/02/2010 04:39 PM, Daniel Walker wrote:
>> > I'm ok with doing renames once all the code is merged .. That's always
>> > been one of the options with the Google code.
>> >
>> > However, we need some future direction .. If we do a rename later on
>> > with the older code, then we ideally want new code to be submitted with
>> > appropriate names..
>>
>> I'm not sure I understand. ?Are you suggesting that
>> code for new boards developed for Android phones be submitted
>> under the eventual product names? ?That's really not possible
>> if you want the code submitted before the product ships, because
>> the marketing department often finalizes a product name late
>> in the development cycle.
>
> No, It would be nice if the mass marketing name is known in advance,
> otherwise you have to use a code name .. Some phones however might have
> multiple code names..

As Tim points out, this is rarely the case -- marketing names are
quite often a late-binding decision.

As has been pointed out elsewhere it's not uncommon for devices to
ship under a number of different marketing names in different
environments.

Trying to optimize for matching the board name with the
most-recognized marketing name (something that may not be at all
possible to know until long after ship) seems like a lot of work for
little gain.

As Russell points out, one can provide guidance in the Kconfig
description and comments.

I continue to be somewhat amazed that this keeps coming up -- I'm
prepared to have people tell me my code sucks, or that we need to fix
style violations, or that they don't like the wakelock API, etc, but
it just blows my mind that somehow the big issue is that the board
files are named based on the development codenames of the projects
that they're for.  In my experience, this is common practice, and
based on glancing through mach-types, etc, does not seem uncommon even
in the ARM linux world.

Brian
