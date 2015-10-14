From: majun258@huawei.com (majun (F))
Date: Wed, 14 Oct 2015 16:54:33 +0800
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <alpine.DEB.2.11.1510141019060.25029@nanos>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos> <5618D3EC.6050501@huawei.com>
 <20151010110942.52d34a4b@arm.com> <alpine.DEB.2.11.1510111150270.6097@nanos>
 <20151011120331.09093ffc@arm.com> <alpine.DEB.2.11.1510111335150.6097@nanos>
 <561CA58C.2060207@huawei.com> <alpine.DEB.2.11.1510130842070.6097@nanos>
 <561E0F4F.3080202@huawei.com> <alpine.DEB.2.11.1510141019060.25029@nanos>
Message-ID: <561E1849.5050809@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/10/14 16:20, Thomas Gleixner ??:
> On Wed, 14 Oct 2015, majun (F) wrote:
>> But there is no interrupt-map property in GIC or mbigen node.
> 
> Again: I'm not a DT expert. Please discuss that with Marc and the DT
> wizards.
> 
> Thanks,
> 
> 	tglx
> 
> .

Ok.
Marc, what's your suggestion ? much appreciated

Thanks!
Ma Jun


> 
