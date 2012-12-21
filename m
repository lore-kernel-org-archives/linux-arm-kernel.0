From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Dec 2012 10:05:35 +0100
Subject: [GIT PULL] Fixes for sunxi for 3.8 merge window
In-Reply-To: <20121220160132.GB1034@quad.lixom.net>
References: <1355906760-23041-1-git-send-email-maxime.ripard@free-electrons.com>
 <20121220160132.GB1034@quad.lixom.net>
Message-ID: <50D4265F.4080307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/12/2012 17:01, Olof Johansson a ?crit :
> On Wed, Dec 19, 2012 at 09:46:00AM +0100, Maxime Ripard wrote:
>> Arnd, Olof,
>>
>> Please consider pulling these two (late) patches for the sunxi support.
>>
>> The first one add the support for the sunxi architecture in the multiplatform
>> kernel, allowing to easily build a kernel that boots on the sun4i/sun5i
>> supported boards.
>>
>> The second one fixes some compatible strings that were left behind in the
>> previous compatible renaming patch, preventing the kernel from booting.
>>
>> Thanks,
>> Maxime 
>>
>> The following changes since commit 7445d6b5a7a40c40cda3935ba3827896305cfc21:
>>
>>   ARM: sunxi: Change device tree naming scheme for sunxi (2012-12-18 15:11:16 +0100)
>>
>> are available in the git repository at:
>>
>>   git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8-rc1
>>
>> for you to fetch changes up to 91e4f61216c6e15f7ff99f2d18407a08cfe601b0:
>>
>>   sunxi: Change the machine compatible string. (2012-12-19 09:23:42 +0100)
>>
>> ----------------------------------------------------------------
>> Fixes for the sunxi core to be merged in 3.8-rc1
>>
>> ----------------------------------------------------------------
>> Maxime Ripard (2):
>>       ARM: multi_v7_defconfig: Add ARCH_SUNXI
>>       sunxi: Change the machine compatible string.
> 
> Hi,
> 
> I get more than those patches when I pull that tag, and it seems like some of
> them are now invalid. Like "ARM: sunxi: Add missing sun4i.dtsi file", which 
> will add a fresh sun4i.dtsi, when it's already been added and renamed
> sun4i-a10.dtsi.

Hi,

This patch has been sent by Stefan Roese and was applied by Arnd I
believe (Commit 7423d2d8), so I took it in my tree for the next patches
to apply cleanly as well.

And then came the patch that was not doing the renaming, and one of that
renamed files was actually sun4i.dtsi to sun4i-a10.dtsi.

I'm not sure how we should handle those, do you want me to send you
patches? maybe it'll be easier for you to apply these changes?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
