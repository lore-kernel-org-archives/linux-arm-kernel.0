From: jcmvbkbc@gmail.com (Max Filippov)
Date: Wed, 27 Jan 2016 07:33:30 +0300
Subject: [PATCH 09/15] xtensa: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453868872-26300-10-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-10-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAMo8Bf+KhgFEGuF3+9+_KbF=FM+SRFRojLowLXVhEeoXZHpXnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 7:27 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/xtensa/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
