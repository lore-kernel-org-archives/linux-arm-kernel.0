From: nm@ti.com (Menon, Nishanth)
Date: Wed, 30 May 2012 09:45:42 -0500
Subject: [PATCHv2 09/19] ARM: OMAP4: PM: add errata support
In-Reply-To: <1338366759.8834.124.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-10-git-send-email-t-kristo@ti.com>
 <CAOMWX4dmt2jUOpkgFC=o5oez3CfUVzF_0NTkm23qrNQDDpmo9w@mail.gmail.com>
 <1338366759.8834.124.camel@sokoban>
Message-ID: <CAOMWX4dKgnv54rkEVQL7YW8i2Ymz+cMvbQ7WgNnnNrYhbMHFXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 3:32 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On Tue, 2012-05-29 at 15:10 -0500, Menon, Nishanth wrote:
>> On Mon, May 14, 2012 at 5:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> > Added similar PM errata flag support as omap3 has. A few errata flags
>> > will be added in subsequent patches.
>>
>> Considering that we might have erratas for future SoCs as well,
>> should'nt we just
>> set up a common errata flag for all SoCs and since we have i123 numbers, would
>> it help being able to reuse errata flags cross SoC generations (if we need to)?
>
> Not sure... how quickly do we run out of bits that way? :) Also, at
> least pm34xx / pm44xx erratas don't have anything in common. We can
> probably re-use pm44xx erratas for omap5 though.
>
> One annoyance is that, the OMAP4 erratas are going to have a number of
> ROM code erratas on them, which don't really have any public i123
> numbers available. >.<

Sounds good to me.

Regards,
Nishanth Menon
