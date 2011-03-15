From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Mar 2011 08:37:24 +0000
Subject: [GIT PULL] ux500,u300,nomadik core changes for 2.6.39
In-Reply-To: <AANLkTikR4tbNRYU_5OKiTevvw+7eCN6N18yUi3kf22Qe@mail.gmail.com>
References: <AANLkTi=3eiAjRdU9unXX13RbBHT-pPm+ujgsB0VpctiS@mail.gmail.com>
	<AANLkTikR4tbNRYU_5OKiTevvw+7eCN6N18yUi3kf22Qe@mail.gmail.com>
Message-ID: <20110315083724.GB3921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 07:33:20PM +0100, Linus Walleij wrote:
> Of all the mistakes I do I don't know what deep personal deficiency makes
> me constantly miss to add the mailinglist CC to mails like this.
> 
> (And yes, I noticed RMK has a diskcrash to solve so I don't expect any
> hasty action on this, noted.)

Not a disk crash, more a SWSUSP buggeration.  You don't really expect
to find an ARM vmlinux in your inode tables after resuming from
suspend-to-disk.
