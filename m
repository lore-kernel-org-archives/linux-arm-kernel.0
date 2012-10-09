From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 20:44:31 -0600
Subject: [PATCH 0/6] ARM: Add support for Broadcom BCM476x SoCs
In-Reply-To: <20121007101418.GA24323@glitch>
References: <20121007015300.828366635@gmail.com>
 <5071118A.6040508@wwwdotorg.org> <20121007101418.GA24323@glitch>
Message-ID: <50738F8F.3030006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2012 04:14 AM, Domenico Andreoli wrote:
> On Sat, Oct 06, 2012 at 11:22:18PM -0600, Stephen Warren wrote:
>> On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
>>>
>>> Additional support is being worked on.... and usb (DWC OTG) only
>>> attemped reusing s3c-hsotg.
>>
>> Hmmm. I believe the bcm2835 uses DWC OTG. I wonder if the same driver
>> will work there; USB in particular is a major pain point on the bcm2835...
> 
> I don't know any more how many versions of this driver are circulating,
> we may have some options.
> 
>>> It's based on a random pre v3.7-rc1 commit (eb0ad9c) with mainlined
>>> multi-platform support and Stephen's patch to add DEBUG_LL to it.
>>
>> ...
>> about uncompress.h now. Unless anyone really pipes up and says they'd
>> still like me to pursue uncompress.h in multi-platform, I'm inclined to
>> drop it.
> 
> I think it is valuable, multi-platform doesn't have any DEBUG_LL or
> earlyprintk support

Why do you say that? Locally I have ported Tegra to multi-platform and I
certainly have earlyprintk enabled, and I dropped the patches to support
uncompress.h in multi-platform from my local work branch.
