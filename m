From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 09:42:56 -0600
Subject: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with DEBUG_LL
In-Reply-To: <54ABFCA7.3080306@ti.com>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
 <20150106140517.GA3897@kahuna> <20150106150851.GB6502@saruman>
 <54ABFCA7.3080306@ti.com>
Message-ID: <20150106154256.GF6502@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 09:17:59AM -0600, Nishanth Menon wrote:
> On 01/06/2015 09:08 AM, Felipe Balbi wrote:
> > On Tue, Jan 06, 2015 at 08:05:17AM -0600, Nishanth Menon wrote:
> >>> For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> >>>
> >>> Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data)
> >>
> >> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")
> > 
> > what's the difference ? why do you want that many more characters if
> > those 7 are enough for git to find a uniq commit ? Try this:
> > 
> > $ git show --abbrev-commit 90020c7b2c5e02200bc752c8cfeba91c4435588c
> > 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n160

alright, if it's Documented, it's best done ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/ead50429/attachment.sig>
