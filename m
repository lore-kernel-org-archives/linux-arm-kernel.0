From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 02 Oct 2012 11:38:18 +0200
Subject: OMAP baseline test results for v3.6-rc7
In-Reply-To: <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com>
 <50645A1D.5040108@compulab.co.il>
 <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
Message-ID: <506AB60A.5040901@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/12 01:28, Paul Walmsley wrote:
> On Thu, 27 Sep 2012, Igor Grinberg wrote:
> 
>> Have you tried the nohlt boot parameter?
>> It looks like the wfi is killing those SoCs once you use EMAC.
> 
> Just tried with nohlt.  Didn't help on CM-T3517 with either NFS or MMC 
> root, nor with the 3517EVM with NFS root.  But I was able to get the 
> 3517EVM booting to userspace with MMC root.  Looks like the CM-T3517 board 
> file is missing the MMC setup code, so would guess that adding that back 
> in would help.

It never had the MMC in mainline...
I have some patches for that, based on v3.5,
but it should not be a problem to rebase those on a more recent git.
I will send them in a week or so, and if Tony will agree to merge them,
we will have the MMC on CM-T3517 mainline.


-- 
Regards,
Igor.
