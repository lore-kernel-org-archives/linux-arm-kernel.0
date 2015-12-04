From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Dec 2015 12:03:53 +0000
Subject: [PATCH v3 0/2] arm64: stop using kstop_machine for ftrace
In-Reply-To: <1449200320-24854-1-git-send-email-huawei.libin@huawei.com>
References: <1449200320-24854-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <20151204120353.GC26172@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:38:38AM +0800, Li Bin wrote:
> v2:
> Based on the comments from Will and Steve,
> 1. Modify the commit message
> 2. Fix the misleading comments for ftrace_modify_code
> 
> v3:
> Modify the comments again based on the comment from Steve.
> 
> Link: https://lkml.org/lkml/2015/12/3/422
> 
> Li Bin (2):
>   arm64: ftrace: stop using kstop_machine to enable/disable tracing
>   arm64: ftrace: fix the comments for ftrace_modify_code

Thanks, I'll queue both of these for 4.5.

Will
