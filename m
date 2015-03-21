From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sat, 21 Mar 2015 17:17:36 +0000
Subject: [PATCH 10/10] ARM: s3c64xx: allow building without board support
In-Reply-To: <1425299763-4066822-11-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-11-git-send-email-arnd@arndb.de>
Message-ID: <20150321171736.GF23705@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:36:03PM +0100, Arnd Bergmann wrote:
> Most of the code for the s3c64xx platform is only used when booting
> with ATAGS based board files, but not when using device-tree.
> 
> This tries to identify all the s3c64xx specific code that is
> unneeded when CONFIG_ATAGS is not set, so we can build a smaller
> DT-only kernel if configured that way.
> 
> All board support is still left intact but now depends on the
> CONFIG_ATAGS symbol that users may intentionally disable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Rest of this series doesn't seem to cause me any problems on
Cragganmore.

Thanks,
Charles
