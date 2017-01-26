From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 12:20:01 +0000
Subject: [PATCH] arm64: Kconfig: select COMPAT_BINFMT_ELF only when
 BINFMT_ELF is set
In-Reply-To: <1485400795-51078-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1485400795-51078-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20170126122001.GE14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:19:55AM +0800, Kefeng Wang wrote:
> Fix warning:
> "(COMPAT) selects COMPAT_BINFMT_ELF which has unmet direct dependencies
> (COMPAT && BINFMT_ELF)"
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied for 4.11.

Will
