From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 22 Mar 2011 21:09:22 +1000
Subject: Support for ARM940T core Samsung S3C2510A MCU under Linux
In-Reply-To: <201103211320.38227.arnd@arndb.de>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com>
	<201103192114.05164.arnd@arndb.de> <4D873890.5000302@snapgear.com>
	<201103211320.38227.arnd@arndb.de>
Message-ID: <4D888362.7050309@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 21/03/11 22:20, Arnd Bergmann wrote:
> On Monday 21 March 2011, Greg Ungerer wrote:
>>> I could not find a git tree for uClinux that contains any recent
>>> kernel. Does that exist?
>>
>> I used to keep one on git.kernel.org for promoting non-architectural
>> but non-MMU specific changes to mainline.
>>
>> http://git.kernel.org/?p=linux/kernel/git/gerg/uclinux.git;a=summary
>>
>> But I have had so few changes that fit in that category that I
>> haven't used it in quite a while.
>
> Yes, I found that tree when I looked last week. I was wondering
> if there is any git or other repo for the files that are in
> http://sourceforge.net/projects/uclinux/files/uClinux%20Stable/
>
> The kernel sources there are newer than the ones from uclinux.git,
> but I could not find a pointer to who maintains them or how.

There is no git tree or otherwise for the code in the uclinux-dist
source package. It is just a random collection of patches collected
over the years, with new kernels "imported" every new release.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
