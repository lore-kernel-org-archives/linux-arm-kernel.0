From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jul 2017 10:28:27 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <AM4PR08MB2659BFF0EAEB020F7571A115D5DF0@AM4PR08MB2659.eurprd08.prod.outlook.com>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
 <20170626101304.GG4902@n2100.armlinux.org.uk>
 <20170626133255.GH8543@e103592.cambridge.arm.com>
 <20170626144001.GH4902@n2100.armlinux.org.uk>
 <AM4PR08MB2659BFF0EAEB020F7571A115D5DF0@AM4PR08MB2659.eurprd08.prod.outlook.com>
Message-ID: <20170719092827.GA28445@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 03:14:13PM +0000, Edmund Grimley-Evans wrote:
> As a user (I recently implemented a work-around for this problem in DynamoRIO: https://github.com/DynamoRIO/dynamorio/commit/0b75c635033d01ab04f955f5affe14a3ced9ab56) I'm happy with any of the proposed solutions, provided that in the "invalid magic number" case user space is not required to regenerate the bogus block with the same invalid magic number when invoking sigreturn.

I have to ask why a bug report was never sent to kernel people on this.
If no one tells people that software is buggy, that software stands
little chance of being fixed!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
