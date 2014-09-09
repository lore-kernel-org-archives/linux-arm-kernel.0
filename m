From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 9 Sep 2014 11:04:12 -0500
Subject: [GIT PULL 1/2] SOCFPGA updates for 3.18
In-Reply-To: <15438682.g2WSItt3Xr@wuerfel>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <15438682.g2WSItt3Xr@wuerfel>
Message-ID: <540F24FC.2070008@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 09:55 AM, Arnd Bergmann wrote:
> On Thursday 04 September 2014 11:11:44 dinguyen at opensource.altera.com wrote:
>> Hi Arnd, Kevin and Olof,
>>
>> Please consider pulling in these patches for v3.18. 5 of the 6 patches are
>> DTS updates and the 1 patch is updating the MAINTAINERS entry with my new
>> email address.
> 
> Pulled into next/dt. It would be nice if you could in the future
> separate the DT updates from the other changes more, even if that means
> sending a separate patch or pull request for something as trivial as
> the MAINTAINERS update.

Will keep this in mind in the future.
> 
> For some reason your pull request ended up in my spam folder, where
> I only found it today when looking for something else. I don't know
> why this happened, but you might want to watch out for this happening
> again, and ping us if a future pull request doesn't get merged within
> a couple of days. 
> 

I was going to give it a week.

>>
>> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
>>
>>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_update_for_v3.18
>>
>> for you to fetch changes up to 75a41826e2c5dc1dc0fd5195fc29b031c97337af:
>>
>>   arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries. (2014-09-04 10:15:52 -0500)
>>
>> ----------------------------------------------------------------
>> arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries.
>>
> 
> Please try to be a little more verbose with the changelog, as this
> is what ends up in the git history for the merge commit.
> 

Will do...

Thanks,
Dinh
