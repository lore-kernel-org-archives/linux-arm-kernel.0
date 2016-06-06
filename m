From: daniel@iogearbox.net (Daniel Borkmann)
Date: Mon, 06 Jun 2016 10:11:25 +0200
Subject: [PATCH net-next 1/3] arm64: bpf: implement bpf_tail_call() helper
In-Reply-To: <CABg9mcv0kYvk7-wsfVR3fg0nBBDVbs0QtTiWZfGRDqq7kGeFPQ@mail.gmail.com>
References: <201606050700.BLJUHUk2%fengguang.wu@intel.com>
 <5753DA61.3000505@iogearbox.net>
 <CABg9mcv0kYvk7-wsfVR3fg0nBBDVbs0QtTiWZfGRDqq7kGeFPQ@mail.gmail.com>
Message-ID: <5755302D.1000708@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 06:56 AM, Z Lim wrote:
[...]
> How about the attached patch? Fixes compilation error on build
> !CONFIG_BPF_SYSCALL.
>
> Also, should this patch be sent to net or net-next (along with this series)?

Looks good, feel free to add:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

I think net-next along with your series should be fine since the issue
first appeared there. Thanks, Zi!
