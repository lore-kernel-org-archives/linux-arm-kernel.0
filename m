From: robherring2@gmail.com (Rob Herring)
Date: Fri, 30 Jan 2015 15:03:36 -0600
Subject: [PATCH] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <201501301514.14884@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201501262009.45854@pali>
 <CAL_JsqKNq4mY9vwDBPGYLmSYpTnYqS4QvjkbMkD6LJpxDYoLAg@mail.gmail.com>
 <201501301514.14884@pali>
Message-ID: <CAL_JsqLvj3zW9v+R3y8uOi8ZCPj5Q+NT057j-8URHavDeWqUAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lOn Fri, Jan 30, 2015 at 8:14 AM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> On Monday 26 January 2015 21:22:27 Rob Herring wrote:
>> On Mon, Jan 26, 2015 at 1:09 PM, Pali Roh?r
> <pali.rohar@gmail.com> wrote:
>> > Ok, here is patch which set Revision field (global variable
>> > system_rev) in /proc/cpuinfo from DT revision property:

[...]

>> > I do not know which DT property to use for storing HW
>> > Revision, so if "/revision" is not correct one, let me know
>> > what to use instead. Also you can add my Signed-off-by for
>> > both patches.
>>
>> It is the correct property, but /revision in DT is a string.
>>
>> You need to add your own sign-off.
>>
>> Rob
>
> Any documentation which says that /revision is string?

Sorry, I was confusing this with serial-number, so I guess a number is
fine here.

> If it is really string, how to store ATAG_REVISON (number) to
> string? dec or hex?

However /proc/cpuinfo displays it would be fine if you stay with a string.

Rob
