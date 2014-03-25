From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Mar 2014 20:00:03 -0400
Subject: linux-next: manual merge of the keystone tree with the arm-soc
 tree
In-Reply-To: <20140325105501.e63fcdd78d0d604b4e5309a1@canb.auug.org.au>
References: <20140325105501.e63fcdd78d0d604b4e5309a1@canb.auug.org.au>
Message-ID: <5330C703.5030705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 07:55 PM, Stephen Rothwell wrote:
> Hi Santosh,
> 
> Today's linux-next merge of the keystone tree got a conflict in
> arch/arm/boot/dts/Makefile between commit ba5a37e52194 ("ARM: mvebu: Move
> kirkwood DT boards into mach-mvebu") from the arm-soc tree and commit
> 400550ae7e77 ("ARM: dts: Build all keystone dt blobs") from the keystone
> tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
Looks fine. Thanks

Regards,
Santosh
