From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 Dec 2013 11:18:27 -0800
Subject: [PATCH] KVM: Documentation: Fix typo for KVM_ARM_VCPU_INIT ioctl
In-Reply-To: <1386864747-29006-3-git-send-email-anup.patel@linaro.org>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
 <1386864747-29006-3-git-send-email-anup.patel@linaro.org>
Message-ID: <20131213191827.GY2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:42:24PM +0530, Anup Patel wrote:
> Fix minor typo in "Parameters:" of KVM_ARM_VCPU_INIT documentation.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  Documentation/virtual/kvm/api.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index a30035d..aad3244 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2327,7 +2327,7 @@ current state.  "addr" is ignored.
>  Capability: basic
>  Architectures: arm, arm64
>  Type: vcpu ioctl
> -Parameters: struct struct kvm_vcpu_init (in)
> +Parameters: struct kvm_vcpu_init (in)
>  Returns: 0 on success; -1 on error
>  Errors:
>   ?EINVAL: ???the target is unknown, or the combination of features is invalid.
> -- 
> 1.7.9.5
> 

-- 
Christoffer
