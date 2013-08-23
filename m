From: s-anna@ti.com (Suman Anna)
Date: Fri, 23 Aug 2013 11:56:55 -0500
Subject: [PATCHv3 0/8] omap mailbox dt
In-Reply-To: <1375825193-18046-1-git-send-email-s-anna@ti.com>
References: <1375825193-18046-1-git-send-email-s-anna@ti.com>
Message-ID: <52179457.2080203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Benoit,

> This is an updated series for adding the device tree support to
> the OMAP mailbox driver. The series is based on 3.11-rc4 and now
> includes the support for AM335 WkupM3 mailbox.
> 
> The support for WkupM3 mailbox is essential for achieving the PM
> Suspend on AM335 devices, and this series is a dependency for
> the AM335 suspend/resume series [1]. The AM335 support patches
> required the mailbox DT patches posted previously, so I have
> refreshed all of them together.
> 
> Tested this on Beagle-XM, Panda4 and OMAP5 uEVM (with
> out-of-tree clock patches).
> 
> v3:
> - Includes 3 new patches on top of the unchanged patches in v2.
> - Patches 7 and 8 adds the driver support and DT node for AM335.
> - Patch6 is a minor cleanup patch removing omap_mbox_type_t from
>   mbox ops.

Any additional feedback/comments on this series? The series contains
patches both for the driver code and DT/hwmod data. Let me know if you
need me to rearrange the patches. I currently have one review comment
to address regarding adding some additional notes [1] to the DT binding
information.

regards
Suman

[1] http://marc.info/?t=137582575400006&r=1&w=2
