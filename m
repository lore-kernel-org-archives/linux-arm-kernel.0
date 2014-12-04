From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 04 Dec 2014 16:28:28 +0000
Subject: [PATCH v12 6/7] kprobes: Pass the original kprobe for preparing
 optimized kprobe
In-Reply-To: <1417671350-53346-1-git-send-email-wangnan0@huawei.com>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>
 <1417671350-53346-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1417710508.2239.14.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-12-04 at 13:35 +0800, Wang Nan wrote:
> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> 
> Pass the original kprobe for preparing an optimized kprobe arch-dep
> part, since for some architecture (e.g. ARM32) requires the information
> in original kprobe.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Wang Nan <wangnan0@huawei.com>

Seems strange cc'ing yourself :-) That should be Signed-off-by instead,
as you're the person sending out the patch.

[rest of patch trimmed]

-- 
Tixy
