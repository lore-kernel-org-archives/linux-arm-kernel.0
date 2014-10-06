From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Oct 2014 08:38:12 -0300
Subject: [PATCH] serial: mxs-auart: add sysrq support
In-Reply-To: <54327E41.9070607@elproma.com.pl>
References: <20140929014129.GA8687@kroah.com>
 <1411999905-27044-1-git-send-email-j.uzycki@elproma.com.pl>
 <CAOMZO5Cctk4UNvK2=MC9tf2Fzi1r0+qdn-SXfC-=W9n3T=a+VA@mail.gmail.com>
 <54327E41.9070607@elproma.com.pl>
Message-ID: <CAOMZO5B94UjrpcksXeMRLZ_sV-GPv252xGs8E+y7NLXtMKOxVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 6, 2014 at 8:34 AM, Janusz U?ycki <j.uzycki@elproma.com.pl> wrote:
> Hi,
>
> W dniu 2014-10-04 18:19, Fabio Estevam pisze:
>
>> Janusz,
>>
>> On Mon, Sep 29, 2014 at 11:11 AM, Janusz Uzycki <j.uzycki@elproma.com.pl>
>> wrote:
>>>>
>>>> So I'm deleting all of these now, please resend the latest
>>>> versions you have, with properly versioning
>>>> and order information.
>>>
>>> Sure. If you don't want to comment dirty patches
>>> I will not send you them.
>>> I can send you only the final version, commented before.
>>>
>>> On the moment this patch is ready to apply.
>>>
>>> [PATCH RESEND] serial: mxs-auart: add sysrq support
>>> The patch is resent to apply.
>>
>> What Greg is asking you to do is to provide a proper version
>> annotation in your patches.
>>
>> For example: [PATCH v2] serial: mxs-auart: add ...
>>
>> Then if you need to submit it again you should do:
>>
>> [PATCH v3] serial: mxs-auart: add ...
>
>
> I will resend the rest of patches (as v4) this week.
> This simple patch is independent from the previous patchset so
> I decided to resubmit it alone ([PATCH RESEND] header used)
> to apply.
>
> I rather shouldn't resend the patch again I guess.
> I sent the same initial version of the patch twice
> after Greg's email so I did mess enough I think.
>
>> Also, always explain below the --- line what changed from one version to
>> another
>
> I thought composing cover letter is the only solution for resent patch or
> series.
> As I understood this way is appropriate for single patch only (not patch
> set).
> "Below" - it means between the line and diffstat?
> Should I add new/second '---' line before diffstat?

Just do something like:

When using mxs-auart based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there,
this patch just simply enable it.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
Changes since v3:
- bla bla bla
