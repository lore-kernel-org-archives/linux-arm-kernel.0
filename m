From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 1 Jun 2016 10:03:42 +0800
Subject: [PATCH resend v2 1/6] regulator: axp20x: support AXP809 variant
In-Reply-To: <20160531173647.GJ29837@sirena.org.uk>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
 <1464711804-19256-2-git-send-email-wens@csie.org>
 <20160531173647.GJ29837@sirena.org.uk>
Message-ID: <CAGb2v67eVjNnON1pAPKMSMgq83sk6u7Q53qDs0dTEbhyTAR_gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 1:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 01, 2016 at 12:23:19AM +0800, Chen-Yu Tsai wrote:
>> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
>> though a few LDOs were removed, and a new switch output added. Like the
>> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
>> to DCDC1 and DCDC5, respectively.
>>
>> Add support for this new variant. Also remove the "axp22x_" prefix from
>> DC1SW/DC5LDO supply handling code, as the AXP809 uses it as well.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>
> Please preserve tags when people review things.  Why wasn't this applied
> when I originally reviewed it?

The mfd patches this one depended on were pushed around a week before
the merge window, about a month after you reviewed, merged, then backed
out this patch. There was no immutable branch either.

I thought it best to wait a cycle instead of rushing in a patch at the
last minute.

Regards
ChenYu
