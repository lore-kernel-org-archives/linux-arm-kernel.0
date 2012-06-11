From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 11 Jun 2012 22:46:26 +0530
Subject: [PATCH 2/6] ARM: OMAP AM33xx: voltagedomain: Add voltage domain
 data
In-Reply-To: <alpine.DEB.2.00.1206111008410.5849@utopia.booyaka.com>
References: <20120521184053.22565.90037.stgit@dusk>
 <20120521184156.22565.87926.stgit@dusk>
 <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com>
 <4FD5B83E.6020807@ti.com>
 <alpine.DEB.2.00.1206111008410.5849@utopia.booyaka.com>
Message-ID: <4FD627EA.7080606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/11/2012 9:40 PM, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> On Mon, 11 Jun 2012, Vaibhav Hiremath wrote:
> 
>> I think this is not required, since Tony has already accepted the patch
>> which has this implementation (available on linux-omap/master).
>> Please refer to the commit,
>>
>> commit 08f3098928c991560408e8c71d4af8b1a3ff2d67
>> Author: Afzal Mohammed <afzal@ti.com>
>> Date:   Fri May 11 00:38:49 2012 +0530
>>
>>     ARM: OMAP2+: am33xx: Add AM335XEVM machine support
> 
> Thanks, that's what I need.  Looks like our series needs to be based on 
> this commit, rather than mainline.
> 

Yes, its already done. As you know I maintain this branch which always
follows mainline and also integrates all the changes discussed on the list -

https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging

Thanks,
Vaibhav
