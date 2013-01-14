From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 21:16:28 +0200
Subject: [PATCH REBASE 0/6] i2c: omap: misc changes
In-Reply-To: <1355502849-9289-1-git-send-email-balbi@ti.com>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Message-ID: <20130114191628.GB9402@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 14, 2012 at 06:34:03PM +0200, Felipe Balbi wrote:
> this is just a rebase of the previous series adding support
> for amount of bytes transferred upon NACK.
> 
> Well, actually the patches implementing transferred bytes
> reporting aren't here because we need to discuss how to move
> forward.
> 
> This series is just a preparation for that, but it also
> contains a at least one bugfix.
> 
> Each and every patch has been tested with pandaboard, it
> would be nice to get Tested-bys from other folks on other
> platforms before pushing this for v3.9 (there's more than
> enough time for that).
> 
> Note that we're also dropping b_hw flag since that becomes
> useless since we'll never set STT and STP together anymore.
> 
> Give it a good round of test, please.

Wolfram, I have these patches rebased on top of v3.8-rc3 if you wish.
Let me know if I should resend them (again).

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/ab751ed8/attachment.sig>
