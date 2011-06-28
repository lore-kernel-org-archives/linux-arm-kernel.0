From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jun 2011 23:12:28 +0200
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
Message-ID: <201106282312.28285.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 June 2011 22:17:30 Nicolas Pitre wrote:
> Commit bcae8aeb32 "[ARM] S3C24A0: Initial architecture support files"
> brought in a bunch of files while explicitly leaving out the corresponding
> Kconfig entry, stating that the series is not complete.
> 
> More than 2.5 years later, the support for this has not seen any progress.
> This is therefore dead code.  If someone wants to revive this code, it is
> always possible to retrieve it from the Git repository.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Good catch!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Do you want to submit that into a new branch for removing obsolete stuff?
