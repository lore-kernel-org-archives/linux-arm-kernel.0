From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 22 Sep 2017 13:01:39 +0800
Subject: [PATCH] ARM: mxs: constify platform_suspend_ops
In-Reply-To: <be1c12e8040201dcabec64561ec6e446e2111b1e.1504111357.git.arvind.yadav.cs@gmail.com>
References: <be1c12e8040201dcabec64561ec6e446e2111b1e.1504111357.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170922050137.GA26358@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 10:17:51PM +0530, Arvind Yadav wrote:
> platform_suspend_ops are not supposed to change at runtime.
> Functions suspend_set_ops working with const platform_suspend_ops.
> So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thanks.
