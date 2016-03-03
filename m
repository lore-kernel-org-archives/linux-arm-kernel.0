From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 3 Mar 2016 14:07:08 +0800
Subject: Suspicious error for CMA stress test
In-Reply-To: <56D79284.3030009@redhat.com>
References: <56D6F008.1050600@huawei.com> <56D79284.3030009@redhat.com>
Message-ID: <56D7D48C.6010505@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

Thanks a lot for taking a look!

On 2016/3/3 9:25, Laura Abbott wrote:
> (cc -mm and Joonsoo Kim)
>
>
[...]
>
> I played with this a bit and can see the same problem. The sanity
> check of CmaFree < CmaTotal generally triggers in
> __move_zone_freepage_state in unset_migratetype_isolate.
> This also seems to be present as far back as v4.0 which was the
> first version to have the updated accounting from Joonsoo.

Would you mind point out the specific commit ID?

Thanks
Hanjun
