From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 28 May 2015 09:50:33 -0700
Subject: [PATCH v8 4/7] clk: hisilicon: Remove __init for marking function
 prototypes
In-Reply-To: <1432440671-25235-1-git-send-email-bintian.wang@huawei.com>
 (Bintian Wang's message of "Sun, 24 May 2015 12:11:09 +0800")
References: <1432440671-25235-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <7hr3q0k5nq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bintian Wang <bintian.wang@huawei.com> writes:

> __init markings on function prototypes are useless, so remove
> them.
>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>

Can you repost the whole series please?  

The number of patches has increased and it's not terribly obvious how to
combine your v7 or v8 patches with the v8 patches for proper testing.

Thanks,

Kevin
