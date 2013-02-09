From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 12:10:09 +0000
Subject: [PATCH 15/17] xgmac: fix printing of hardware version
In-Reply-To: <1360365467-25056-16-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-16-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130209121009.GH17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:45PM +0000, Ben Dooks wrote:
> The current driver attempts to print netdev_info() before registering the
> network device and allowing the name to be set. Change this print to be
> after the network deviec has been registered.

typo: device
