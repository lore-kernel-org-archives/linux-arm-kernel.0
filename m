From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 14:34:18 -0700
Subject: [PATCH 0/5] Add DRA7 sub-mailboxes for 4.4
In-Reply-To: <1442600194-62520-1-git-send-email-s-anna@ti.com>
References: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Message-ID: <20151012213417.GA23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150918 11:20]:
> Hi Tony,
> 
> This series adds the sub-mailbox nodes and enable them for each
> of the TI DRA7 boards. These are the basic mailbox configuration
> nodes required by client users (remoteproc) to communicate with
> the various IPU and DSP processor devices on DRA74x and DRA72x
> SoCs using the TI IPC 3.x software foundation on the remote
> processor firmwares. The mailboxes used are unfortunately
> hardcoded in the TI IPC 3.x software, and hence the weird
> usage of Mailbox 5 and 6 rather than starting from Mailbox 1.
> 
> Any third-party or derived boards can use their own configuration
> if running their own IPC stack, and that can be done by overwriting
> the properties or by using different sub-mailbox nodes altogether.
> The actual enablement of nodes is therefore done in the respective
> board DTS files.
> 
> Patches are based on 4.3-rc1 and are intended for the 4.4 merge
> window.

Thanks applying all into omap-for-v4.4/dt.

Tony
