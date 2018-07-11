From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 11 Jul 2018 10:18:14 -0700
Subject: [PATCH -next] pinctrl: nsp: fix potential NULL dereference in
 nsp_pinmux_probe()
In-Reply-To: <15d64c26-f2c3-e3bb-2768-e5c9726cde49@arm.com>
References: <1531312461-134547-1-git-send-email-weiyongjun1@huawei.com>
 <7b4361a5-f757-179c-57b6-44359801baad@broadcom.com>
 <6c133df2-7dc7-d58b-297a-c27b87e7edd3@arm.com>
 <c0163341-1445-76e2-644f-22cab0735f82@broadcom.com>
 <15d64c26-f2c3-e3bb-2768-e5c9726cde49@arm.com>
Message-ID: <8bbcafd2-db6d-a316-1d15-6af40771d1b6@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/11/2018 10:14 AM, Sudeep Holla wrote:
> 
> 
> On 11/07/18 18:11, Ray Jui wrote:
>>
>>
> 
> [...]
> 
>>
>> I meant there's a reason why xxx_resource was not used, which is most
>> likely due to some resource conflict with another driver on NSP.
>>
> 
> Ah OK, sorry for the noise then.
> 

Not a noise at all. Helpful discussion.

Thanks!

Ray
