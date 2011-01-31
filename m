From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jan 2011 13:20:00 +0000
Subject: [PATCH v3 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <20110131123703.GD8948@n2100.arm.linux.org.uk>
References: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
	<20110131123703.GD8948@n2100.arm.linux.org.uk>
Message-ID: <1296480000.12227.93.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding David Woodhouse to the CC list]

On Mon, 2011-01-31 at 12:37 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 31, 2011 at 10:10:24AM +0000, Marc Zyngier wrote:
> > As the integrator-flash driver is mostly a duplicate of physmap,
> > move all users of this driver to physmap and get rid of the
> > then unused driver.
> 
> With the exception of patch 7, this series looks fine.  Who's merging it?

Do you want me to respin the series without patch 7?

David, could you please comment on this?

Thanks,

	M.
-- 
Reality is an implementation detail.
