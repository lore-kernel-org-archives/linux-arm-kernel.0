From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 1 Aug 2014 16:57:35 +0800
Subject: [PATCH] ARM: l2x0: fix build warning without CONFIG_OF
In-Reply-To: <20140801075843.GO30282@n2100.arm.linux.org.uk>
References: <1406860920-23520-1-git-send-email-wangkefeng.wang@huawei.com>
 <20140801075843.GO30282@n2100.arm.linux.org.uk>
Message-ID: <53DB567F.2070400@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01 15:58, Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2014 at 10:42:00AM +0800, Kefeng Wang wrote:
>> Commit cf9ea8f13(ARM: l2c: remove obsolete l2x0 ops for non-OF init)
>> remove some obsolete l2x0 ops, the rest of ops: l2x0_cache_sync,
>> l2x0_cache_sync, l2x0_disable only use under OF enable, so move them
>> into OF part, or "defined but not used" warning occurs.
> 
> I'm not interested; I've stated previously that I want these warnings
> to stay until such time that the code which uses them is fixed up to
> use the new methods.
> 
> The warnings act as an advertisment that it needs fixing properly.
> 

Ok, ignore pls.
