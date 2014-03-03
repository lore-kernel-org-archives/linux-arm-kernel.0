From: mohun106@gmail.com (Radha Mohan)
Date: Mon, 3 Mar 2014 12:31:56 +0530
Subject: [RFC PATCH 0/1] arm64: Boot time configuration of Intermediate
In-Reply-To: <1393829540-24847-1-git-send-email-mohun106@gmail.com>
References: <1393829540-24847-1-git-send-email-mohun106@gmail.com>
Message-ID: <CAC8NTUVkLm2r_n_T=HLQ-zRA_n4h8792K4O=at9G0V-ywxwEcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore this patch. I have re-sent it with full subject line.

On Mon, Mar 3, 2014 at 12:22 PM,  <mohun106@gmail.com> wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>
> This patch adds support to read the implemented physical address size of
> a platform during boot-time and configure the translation control
> registers.
>
> This patch is a re-written version of
> http://www.spinics.net/lists/arm-kernel/msg311035.html with a new
> subject line to suit the actual thing being done.
>
>
> Radha Mohan Chintakuntla (1):
>   arm64: Add boot time configuration of Intermediate Physical Address
>     size
>
>  arch/arm64/include/asm/kvm_arm.h       |   15 ++++++---------
>  arch/arm64/include/asm/pgtable-hwdef.h |    5 ++---
>  arch/arm64/kvm/hyp-init.S              |    7 +++++++
>  arch/arm64/mm/proc.S                   |    9 ++++++++-
>  4 files changed, 23 insertions(+), 13 deletions(-)
>
