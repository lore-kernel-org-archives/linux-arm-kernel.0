From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue, 11 Nov 2014 19:41:12 +0800
Subject: [PATCH v5 0/6] ARM: mediatek: Add support for interrupt polarity
In-Reply-To: <alpine.DEB.2.11.1411111234220.3935@nanos>
References: <1414576824-16143-1-git-send-email-yingjoe.chen@mediatek.com>
 <20141109053820.GU3698@titan.lakedaemon.net>
 <alpine.DEB.2.11.1411111234220.3935@nanos>
Message-ID: <5461F5D8.7050700@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/11/11 19:35, Thomas Gleixner wrote:
> On Sun, 9 Nov 2014, Jason Cooper wrote:
> 
>> Thomas, Marc,
>>
>> Could I get Acks for the core changes and gic changes when you have
>> a moment?
> 
> this depends on the core irqdomain changes which are not yet in
> tip. I'm waiting for Jiangs latest iteration and Marcs feedback on
> those.
Hi Thomas,
	Sorry for dealy:)
	I think my previous version is good for merging. I only need to
update one patch to address a possible conflict on other architectures.
I'm testing the patch and should send it out soon.
Regards!
Gerry

> 
> Thanks,
> 
> 	tglx
> 
