From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 5 Jun 2018 19:34:43 +0300
Subject: [PATCH v2] drivers: base: cacheinfo: use OF property_read_u32
 instead of get_property,read_number
In-Reply-To: <54785881-da7c-db68-c6a4-70cfd489c1fe@arm.com>
References: <1526898749-17263-1-git-send-email-sudeep.holla@arm.com>
 <1526907189-10031-1-git-send-email-sudeep.holla@arm.com>
 <CAHp75Vd_rQFX1s6jCbj-uLC3K70sSD=s0rt3sWme_f2m90NE5A@mail.gmail.com>
 <54785881-da7c-db68-c6a4-70cfd489c1fe@arm.com>
Message-ID: <CAHp75Vcf5dbcbu-mCeWX7N98HU-hDaOniEXHMuoCGp4yZyAgPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 7:26 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 05/06/18 17:21, Andy Shevchenko wrote:
>> On Mon, May 21, 2018 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> of_property_read_u32 searches for a property in a device node and read
>>> a 32-bit value from it. Instead of using of_get_property to get the
>>> property and then read 32-bit value using of_read_number, we can
>>> simplify it by using of_property_read_u32.
>>>
>>
>> LGTM.
>> Thanks!
>>
>
> Thanks, can I take is Ack ?
>
> Anyways it's too late for v4.18, will repost after the merge window for
> v4.19 with your Ack if you agree.

You can consider like this, though it makes a little change here since
I'm not a maintainer of the code.

-- 
With Best Regards,
Andy Shevchenko
