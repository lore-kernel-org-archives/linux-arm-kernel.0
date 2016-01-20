From: geoff@infradead.org (Geoff Levand)
Date: Wed, 20 Jan 2016 13:18:23 -0800
Subject: [PATCH 09/19] Revert "arm64: remove dead code"
In-Reply-To: <20160115195517.GP3262@leverpostej>
References: <cover.1452884156.git.geoff@infradead.org>
 <81d9f2f035e6ae0e1a121f3eddeaef915d761e2d.1452884156.git.geoff@infradead.org>
 <20160115195517.GP3262@leverpostej>
Message-ID: <1453324703.21755.13.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-01-15 at 19:55 +0000, Mark Rutland wrote:
> On Fri, Jan 15, 2016 at 07:18:37PM +0000, Geoff Levand wrote:
> > This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.
> > 
> > Add back the setup_mm_for_reboot() needed for kexec.
> 
> My pagetable rework series [1,2] adds cpu_install_idmap() [3], which
> supersedes setup_mm_for_reboot, and differs only in name.

OK, I'll switch to cpu_install_idmap.

-Geoff
