From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 31 May 2018 10:13:40 +0530
Subject: [PATCH 0/9] clk: davinci: outstanding fixes
In-Reply-To: <20180530200947.982.19495@harbor.lan>
References: <20180525181150.17873-1-david@lechnology.com>
 <20180530200947.982.19495@harbor.lan>
Message-ID: <8f188ff5-50d1-f128-ecc5-d25edda325d4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 May 2018 01:39 AM, Michael Turquette wrote:
> Hi David,
> 
> Quoting David Lechner (2018-05-25 11:11:41)
>> This is a resend of all of the outstanding DaVinci clock patches plus one new
>> patch. All of the patches (except the new one) have been reviewed and tested
>> by someone other than me.
>>
>> The new patch ("clk: davinci: Fix link errors when not all SoCs are enabled")
>> should be fairly trivial.
>>
>> I am resending them all in one series to hopefully make it easier to get them
>> picked up by having them in the correct order to avoid merge conflicts. This
>> series is based on the clk/clk-davinci-psc-da830 branch.
> 
> I picked them all and pushed to clk/clk-davinci based on -rc1. There are
> some comments on the individual patches, all of which are of the "please
> revisit this and fix it up later" variety.
> 
> Going forward I'm happy for you and/or Sekhar to send clk PRs to Stephen
> and myself. The same rules apply for PRs: all patches need to be posted
> to the list the old fashioned way for review. But PRs make our lives a
> bit easier, especially when dealing with chip variants from the same SoC
> family like we have with davinci.

Thanks Mike! David is listed as maintainer for drivers/clk/davinci/* and
I believe he can be generating pull requests going forward. I can work
as the backup, of course.

Regards,
Sekhar
