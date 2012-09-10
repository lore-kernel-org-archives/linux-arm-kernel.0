From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Sep 2012 09:42:59 +0100
Subject: [PATCH] ARM: add back in KS8695 based SnapGear board entries
In-Reply-To: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
References: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
Message-ID: <20120910084259.GQ13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 01:30:15PM +1000, gerg at snapgear.com wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Board support code for the SnapGear boards based on the Micrel KS8695 SoC
> will soon appear in mainline kernel. The board IDs had been removed from
> the mach-types file, so add them back in.

Nak.  You must add platform support for these numbers _along_ _side_
adding them back to mach-types, otherwise my scripts will simply delete
them again.  These entries have been aged out due to lack of merging of
the platforms.
