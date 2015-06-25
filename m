From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Jun 2015 18:20:57 +0100
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <20150625165741.GA10564@leverpostej>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
 <558C328C.5070803@ti.com> <20150625165741.GA10564@leverpostej>
Message-ID: <20150625172057.GA11952@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I need rework and re-test the patch.
> > One more question. Shall I post the dts related commit, which add PSCI 
> > command together with this commit? Or it may be posted later independently?
> 
> The DTS and Kconfig changes can be seaprate patches, but they'll need to
> go through at the same time.

If your bootloader patches the DTB then you don't even need a dts
update. That should make things less confusing for existing users...

Thanks,
Mark.
