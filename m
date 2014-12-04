From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 04 Dec 2014 16:22:19 +0000
Subject: [PATCH v12 5/7] ARM: kprobes: Add test cases for stack
 consuming instructions
In-Reply-To: <1417671341-53297-1-git-send-email-wangnan0@huawei.com>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>
 <1417671341-53297-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1417710139.2239.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like the source file reorg caused the author of this patch to
change. It should be...

From: Jon Medhurst <tixy@linaro.org>

On Thu, 2014-12-04 at 13:35 +0800, Wang Nan wrote:
> These have extra 'checker' functions associated with them so
> lets make sure those get covered by testing.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> 
>

[rest of patch trimmed]
