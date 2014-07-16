From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 12:40:33 +0200
Subject: [PATCH v3] ARM: save/restore Cortex-A9 CP15 registers on
 suspend/resume
In-Reply-To: <20140716102123.GP21766@n2100.arm.linux.org.uk>
References: <1404974856-25846-1-git-send-email-shawn.guo@freescale.com>
 <alpine.DEB.2.10.1407101704540.2893@Yrabib> <20140714051905.GA2197@dragon>
 <20140716064249.GA2612@dragon> <20140716102123.GP21766@n2100.arm.linux.org.uk>
Message-ID: <53C656A1.5020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16.07.2014 12:21, Russell King - ARM Linux wrote:
> On Wed, Jul 16, 2014 at 02:42:50PM +0800, Shawn Guo wrote:
>> On Mon, Jul 14, 2014 at 01:19:06PM +0800, Shawn Guo wrote:
>>> If no one has objection to the patch, I'm going to put it into patch
>>> tracker soon.
>>
>> Submitted as 8103/1.
> 
> Thanks.  In some ways, I'd like more people to test this before
> applying it, especially as we're at -rc5, but I know full well that
> posting messages to mailing lists won't attract the amount of testing
> that this needs.
> 
> We also know that this will cause breeakage for non-secure platforms,
> and we will need people running those platforms to update their
> resume code.
> 
> The only way which seems to work is to apply it for the next merge
> window, and wait until platform people are forced into testing it
> when it eventually appears in their trees.
> 

On Exynos4210 running in secure mode without any additional patches and
on Exynos4412 running in non-secure mode with few extra
(Exynos-specific) patches:

Tested-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
