From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Jul 2014 07:37:07 +0900
Subject: ASoC: samsung: MACH_SMDK6450
In-Reply-To: <20140702092347.GB410@sirena.org.uk>
References: <1404287238.12021.7.camel@x220>
 <20140702092347.GB410@sirena.org.uk>
Message-ID: <53B48993.5020809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 18:23, Mark Brown wrote:
> On Wed, Jul 02, 2014 at 09:47:18AM +0200, Paul Bolle wrote:
>
>> Your commit 0aeaa68cf509 ("ASoC: samsung: no more support for S5P6440
>> and S5P6450 SoCs") landed in next-20140702. It removed references to
>> MACH_SMDK6440 and MACH_SMDK6450 from sound/soc/samsung/.
>
Yeah, I missed the removing when I created the patch. Paul, thanks for 
your pointing out and I'm resending the updated patch.

> This also wasn't sent to me for review, please always send patches to
> maintainers.

Mark, I always send patches to regarding maintainers and in this case 
the patch missed the change. I'm resending new patch and if any 
problems, please let me know. Just note, I just wanted to check whether 
there is no problem with other maintainers' tree early in -next tree.

Thanks,
Kukjin
