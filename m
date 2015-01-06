From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 09:08:51 -0600
Subject: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with DEBUG_LL
In-Reply-To: <20150106140517.GA3897@kahuna>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
 <20150106140517.GA3897@kahuna>
Message-ID: <20150106150851.GB6502@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 08:05:17AM -0600, Nishanth Menon wrote:
> > For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> > 
> > Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data)
> 
> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")

what's the difference ? why do you want that many more characters if
those 7 are enough for git to find a uniq commit ? Try this:

$ git show --abbrev-commit 90020c7b2c5e02200bc752c8cfeba91c4435588c

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/61afa5b0/attachment.sig>
