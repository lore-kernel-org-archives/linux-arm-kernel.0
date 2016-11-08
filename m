From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Nov 2016 23:57:43 +0100
Subject: [PATCH] ARM: socfpga_defconfig: enable FS configs to support
 Angstrom filesystem
In-Reply-To: <20161108224750.30242-1-dinguyen@kernel.org>
References: <20161108224750.30242-1-dinguyen@kernel.org>
Message-ID: <2911351.Izg0zkPBzd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 8, 2016 4:47:50 PM CET Dinh Nguyen wrote:
> Enables:
> 
> CONFIG_AUTOFS4_FS=y
> CONFIG_NFSD=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> 
> Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 

No objections to the patch, but the changelog should not state what
the patch clearly shows already but instead it should explain why
you do this.

The subject line mentions "to support Angstrom filesystem", but
it's not clear (at least not to me) what that filesystem is.

	Arnd
