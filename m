From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2012 11:04:54 +0100
Subject: [RFC 07/23] ARM: LPAE: use phys_addr_t for membank size
In-Reply-To: <1343092165-9470-8-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-8-git-send-email-cyril@ti.com>
Message-ID: <20120724100454.GD16435@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 02:09:09AM +0100, Cyril Chemparathy wrote:
> This patch changes the membank structure's size field to phys_addr_t to allow
> banks larger than 4G.

This has already been fixed:

  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7465/1

Will
