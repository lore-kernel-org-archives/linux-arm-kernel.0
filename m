From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 14:03:04 +0100
Subject: [PATCH 04/15] ARM: idmap: only initialize HYP idmap when HYP
 mode is available
In-Reply-To: <20120915153455.21241.27798.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153455.21241.27798.stgit@ubuntu>
Message-ID: <20120918130304.GM32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:34:55PM +0100, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mm/idmap.c |    4 ++++
>  1 file changed, 4 insertions(+)

Just fold this into the previous patch.

Will
