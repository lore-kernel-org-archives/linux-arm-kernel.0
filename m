From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Feb 2018 13:58:03 +0100
Subject: [resend,
 PATCH v1] ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly
In-Reply-To: <1519676529.10722.200.camel@linux.intel.com> (Andy Shevchenko's
 message of "Mon, 26 Feb 2018 22:22:09 +0200")
References: <20180129173708.59097-1-andriy.shevchenko@linux.intel.com>
 <87po5s8rtw.fsf@belgarion.home>
 <1519676529.10722.200.camel@linux.intel.com>
Message-ID: <87inai7fok.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2018-01-29 at 19:04 +0100, Robert Jarzmik wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> 
>> > Instead of using PROPERTY_ENTRY_INTEGER() with explicitly supplied
>> > type,
>> > use PROPERTY_ENTRY_U32() dedicated macro.
>> > 
>> > It will help modify internals of built-in device properties API.
>> > 
>> > No functional change intended.
>> > 
>> > Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> 
>> Applied to pxa/for-next branch, thanks.
>
> Can't find either in linux-next, or in your tree on Github.
> Am I looking at wrong locations?
My server on github was not synchronized, it is now :0
My next pull request is around -rc5.

Cheers.

-- 
Robert
