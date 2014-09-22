From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 22 Sep 2014 21:04:28 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <2161168.GXttgFlE1X@vostro.rjw.lan>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140919184849.GA14832@core.coreip.homeip.net>
 <2161168.GXttgFlE1X@vostro.rjw.lan>
Message-ID: <CAPDyKFqT1A=N6=CFHVMq-u+zkYK9zp_Ztmm8OWpftmHY2w68DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 September 2014 16:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, September 19, 2014 11:48:49 AM Dmitry Torokhov wrote:
>> Hi Ulf,
>>
>> On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
>> > Changes in v5:
>> >     - Converted dev_pm_domain_detach() to a void function
>> >     - Added a ->detach() callback to the PM domain struct, invoked from the
>> >       dev_pm_domain_detach().
>> >     - Make ACPI and genpd both assign the ->detach() callback at successfull
>> >       attachment.
>> >     - The above changes made it possible to make acpi_pm_domain_detach() to
>> >       be static, added a separate patch for that.
>>
>> Thank you for making these changes. For the series:
>>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> I've queued up this patchset for 3.18 (I fixed up the two minor issues pointed
> to by Geert in the process).

Thanks Rafael!

Feel free to apply Wolfram's comment on patch 6 as well.

Kind regards
Uffe
