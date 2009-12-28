From: swetland@google.com (Brian Swetland)
Date: Mon, 28 Dec 2009 13:08:27 -0800
Subject: tree with htc dream support
In-Reply-To: <20091228204848.GB1637@ucw.cz>
References: <20091213212504.GD5114@elf.ucw.cz>
	<20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
	<a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
	<20091227203704.GK11737@elf.ucw.cz>
	<20091227211322.GB29174@elf.ucw.cz>
	<a55d774e0912271646m1b82687cy427083e64e91e323@mail.gmail.com>
	<20091227101824.GB1478@ucw.cz>
	<a55d774e0912281224y7360dfdbu8a251743026bdd28@mail.gmail.com>
	<20091228204848.GB1637@ucw.cz>
Message-ID: <a55d774e0912281308u1c20c84cl4f264aa366445131@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 12:48 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > In the short run... the code is staging quality, so it should be in
>> > staging... and you'll not have to mainain so huge diff. (-20 kLoc).
>>
>> The core smd stuff is really not that large. ?The central smd.[ch] are
>> about 1300 lines, and proc_comm.[ch] are about 400 lines. ?Is it
>> possible to get some review/feedback as to what's "staging quality"
>> about this code so we can clean it up? ?I'd rather just fix the
>> issues
>
> Just submit it to Daniel W., ccing rmk and l-a-k, and I'm sure you'll
> get feedback.
>
> For a start, checkpatch has some mild complains.
>
>> and get the core stuff in there so clock, power, etc support is there
>> for the platform rather than have it live in staging purgatory.
>>
>> Since this stuff is integral to mach-msm, required for essential
>> operation of the platform, and makes sense to be part of the mach-msm
>> codebase, why not just fix it there rather than move it out into
>> staging and then back? ?I'm not sure what that gains us.
>
> Well, it is in staging now. I just want you to use the existing
> version, instead of adding another one.

I'm trying to understand where the version in staging came from, how
it's been changed, etc, so I can resolve that against what we have
that's known good and shipping today and make sure we're not losing
bugfixes and such along the way.

Do you remember where the smd code that you put into staging came
from, exactly?  Unfortunately since things have been moved, modified,
renamed, etc, getting clean diffs is a bit of an adventure right now.

When I'm back in the office (on vacation at the moment, trying to stay
caught up on email though) I'll have to start figuring out what went
where and how different it is from what we have today, say in Arve's
.33 based tree.

Brian
