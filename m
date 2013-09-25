From: agraf@suse.de (Alexander Graf)
Date: Wed, 25 Sep 2013 14:13:10 +0200
Subject: [PATCH v4 4/4] KVM: Add documentation for
 KVM_ARM_PREFERRED_TARGET ioctl
In-Reply-To: <1380101163-20028-5-git-send-email-anup.patel@linaro.org>
References: <1380101163-20028-1-git-send-email-anup.patel@linaro.org>
 <1380101163-20028-5-git-send-email-anup.patel@linaro.org>
Message-ID: <ECFE274D-FC43-43AD-8A9E-D3131E327F26@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25.09.2013, at 11:26, Anup Patel wrote:

> To implement CPU=Host we have added KVM_ARM_PREFERRED_TARGET
> vm ioctl which provides information to user space required for
> creating VCPU matching underlying Host.
> 
> This patch adds info related to this new KVM_ARM_PREFERRED_TARGET
> vm ioctl in the KVM API documentation.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
> Documentation/virtual/kvm/api.txt |   27 +++++++++++++++++++++++----
> 1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 858aecf..f31e6e8 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2303,8 +2303,28 @@ Possible features:
> 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
> 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
> 
> +4.83 KVM_ARM_PREFERRED_TARGET

Why 4.83 and not 4.86? It feels backwards to rename all these other sections.


Alex
