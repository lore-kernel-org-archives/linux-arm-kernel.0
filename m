From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 09:29:47 -0800
Subject: [PATCH] arm/arm64: KVM: fix missing unlock on error in
 kvm_vgic_create()
In-Reply-To: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
References: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20150302172947.GC10137@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 07:41:45PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing unlock before return from function kvm_vgic_create()
> in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, applied.
-Christoffer
