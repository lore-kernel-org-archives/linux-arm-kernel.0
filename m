From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 10 Jun 2015 18:00:58 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2, version 2
In-Reply-To: <7hh9qfjhht.fsf@deeprootsystems.com>
References: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com>
 <7hh9qfjhht.fsf@deeprootsystems.com>
Message-ID: <5578C1AA.3000307@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 06:01 PM, Kevin Hilman wrote:
> dinh.linux at gmail.com writes:
> 
>> Hi Arnd, Kevin, Olof,
>>
>> This is an updated pull request for the supend-to-ram patch that has the
>> EDAC code removed in order to avoid a merge conflict.
>>
>> Thanks,
>> Dinh
>>
>> The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:
>>
>>   Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)
> 
> Why v4.1-rc6?  
> 
> Are there specific dependencies there?  If not, we prefer these pulls to
> be on older -rc tags (typically nothing past where arm-soc/master is).

No dependency, I just saw that arm-soc/for-next was at -rc6. I remember
seeing an email that you should based to an early -rc, or the same -rc
as the for-next branch?

> 
> If there are no deps, could you respin this against -rc2/-rc3, or you
> could also rebase on top of your previous socfpga_updates_for_v4.2 as
> well (which itself is based on -rc2.)
> 

Yes, I can do that as, I have an additional patch to be included.

Thanks,
Dinh
