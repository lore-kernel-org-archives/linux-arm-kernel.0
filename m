From: cjb@laptop.org (Chris Ball)
Date: Tue, 12 Apr 2011 15:47:34 -0400
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <20110412193944.GC2665@atrey.karlin.mff.cuni.cz> (Cyril Hrubis's
	message of "Tue, 12 Apr 2011 21:39:44 +0200")
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
Message-ID: <m3oc4bxne1.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 12 2011, Cyril Hrubis wrote:
>> Your symptoms match the bug that was fixed by:
>> 
>> bad3babace2ee4d ("mmc: fix CONFIG_MMC_UNSAFE_RESUME regression")
>> 
>> but this fix made it into 2.6.38, so if you're using 2.6.38 final then
>> you shouldn't be seeing this.  Could you confirm that you have this
>> patch?
>
> It seems that the pxa tree I have is still based on 2.6.38-rc8.
>
> And yes, turning CONFIG_MMC_UNSAFE_RESUME off seems to fix that problem.
>
> I'll try to update the kernel tree and try again with CONFIG_MMC_UNSAFE_RESUME
> enabled.

Okay, great.  It was introduced in 2.6.38-rc1 and fixed in 2.6.38 final.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
