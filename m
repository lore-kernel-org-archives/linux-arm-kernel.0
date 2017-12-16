From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 16 Dec 2017 14:46:18 -0800
Subject: [PATCH] divers/soc/ti: fix max dup length for kstrndup
In-Reply-To: <20171212092935.20211-1-mashimiao.fnst@cn.fujitsu.com>
References: <20171212092935.20211-1-mashimiao.fnst@cn.fujitsu.com>
Message-ID: <5930109a-f31f-8a2a-87bf-70326ed91e16@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/17 1:29 AM, Ma Shimiao wrote:
> If source string longer than max, kstrndup will alloc max+1 space.
> So, we should make sure the result will not over limit.
> 
> Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
> ---
Applied. Thanks !!
