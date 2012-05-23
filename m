From: nm@ti.com (Menon, Nishanth)
Date: Wed, 23 May 2012 08:27:06 -0500
Subject: [linux-pm] [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage
 Scaling)
In-Reply-To: <87pqadgqd5.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
 <20120427175657.GP18260@opensource.wolfsonmicro.com> <87397o3n4y.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
 <87mx5jy2li.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
 <EF62F09C0797D947AD4180A1043C0DF73C40BCE1@DLEE10.ent.ti.com>
 <87lil2jp2z.fsf@ti.com>
 <EF62F09C0797D947AD4180A1043C0DF73C40C247@DLEE10.ent.ti.com>
 <87pqadgqd5.fsf@ti.com>
Message-ID: <CAOMWX4cjzLYuPmA-k=Z_pc5uw=CCViPjRYqs4VTyLX6T8HhtcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 1:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Woodruff, Richard" <r-woodruff2@ti.com> writes:
>
>>> From: Hilman, Kevin
>>> Sent: Tuesday, May 08, 2012 5:17 PM
>>
>>> A basic OMAP AVS driver has been in mainline for a long time, yet we
>>> have not seen support submitted for all of these features.
>>
>> 1.5/3.5 is a feature.
>
> And I'm still waiting for it to be submitted upstream.
>
>> ABB is requirement for a production useable driver. Higher speed rated
>> OMAP4 and all OMAP5 added these to be useable.
>
> ditto
>
>> Yes this is effort. Point of mentioning is to raise awareness of need.
>
> I'm well aware of the need.
>
>> Yet to be added feature has different meaning than functional gap.
>
> And both need to be submitted upstream.

SR 1.5: http://marc.info/?l=linux-omap&m=129933897910785&w=2
ABB: http://marc.info/?l=linux-omap&m=130939399209099&w=2

I am not sure what you mean "need to be submitted upstream"?

Just tired of seeing things perpetually change without considering
even how to handle features that are mandatory for SoC even with code
posted upstream to show exactly what it takes.. I think you do mean
merged upstream in this context.


Regards,
Nishanth Menon
