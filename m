From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 May 2017 08:46:39 -0700
Subject: [PATCH 0/2] Enable Mailboxes for AM57xx IDKs
In-Reply-To: <20170519204742.1563-1-s-anna@ti.com>
References: <20170519204742.1563-1-s-anna@ti.com>
Message-ID: <20170526154639.GD3717@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [170519 13:51]:
> Hi Tony,
> 
> This series enables the mailbox nodes to be used for communicating with
> the DSPs and IPUs on AM57xx IDKs using IPC 3.x. The mailbox nodes themselves
> were already defined/added before for other DRA7 boards, and these patches
> simply enable the respective nodes for the IDKs.
> 
> Patches are based on 4.12-rc1 and are intended for the 4.13 merge
> window.

Applying into omap-for-v4.13/dt thanks.

Tony
