From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Sun, 22 Oct 2017 12:31:38 +0000
Subject: [PATCH 09/11] Don't need to map the shadow of KASan's shadow
 memory
In-Reply-To: <20171019125552.GB20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-10-liuwenliang@huawei.com>
 <20171019125552.GB20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CEFD@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 20:56PM, Russell King - ARM Linux wrote:
>On Wed, Oct 11, 2017 at 04:22:25PM +0800, Abbott Liu wrote:
>>  Because the KASan's shadow memory don't need to track,so remove the  
>> mapping code in kasan_init.
>
>Is there a reason why this isn't part of the earlier patch that introduced the code below?
Thanks for your reviews.
I'm going to change it in the new version.
