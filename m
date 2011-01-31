From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 12:37:03 +0000
Subject: [PATCH v3 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
References: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110131123703.GD8948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 10:10:24AM +0000, Marc Zyngier wrote:
> As the integrator-flash driver is mostly a duplicate of physmap,
> move all users of this driver to physmap and get rid of the
> then unused driver.

With the exception of patch 7, this series looks fine.  Who's merging it?
