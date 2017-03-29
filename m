From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 29 Mar 2017 11:05:32 +0530
Subject: [PATCH v7 0/3] Broadcom FlexRM ring manager support
In-Reply-To: <1490765455-8556-1-git-send-email-anup.patel@broadcom.com>
References: <1490765455-8556-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <CABb+yY3n2OuvBKfsWj5m5RvdBEZ5_aWpVNUJ9V8oikyJjchZAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:00 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> The Broadcom FlexRM ring manager provides producer-consumer style
> ring interface for offload engines on Broadcom iProc SoCs. We can
> have one or more instances of Broadcom FlexRM ring manager in a SoC.
>
> This patchset adds a mailbox driver for Broadcom FlexRM ring manager
> which can be used by offload engine drivers as mailbox clients.
>
> The Broadcom FlexRM mailbox driver is feature complete for RAID and
> Crypto offload engines. We will have incremental patches in-future
> for ring-level statistics using debugfs and minor optimizations.
>
> This patchset is based on Linux-4.11-rc4 and it is also available
> at flexrm-v7 branch of https://github.com/Broadcom/arm64-linux.git
>
> Changes since v6:
>  - Rebased patches for Linux-4.11-rc4
>  - Added a patch to remove depends on COMPILE_TEST for kconfig
>    option BCM_FLEXRM_MBOX
>
You only needed to send the fix to compilation failure reports, not
the whole series.
I believe only the patch-3 is new in the series and I need not even
look at patch-1,2 ?
