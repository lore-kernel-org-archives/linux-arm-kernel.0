From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 5 Mar 2010 10:57:49 -0000
Subject: [PATCH] ARM: Realview/Versatile/Integrator: separate out
	common	clock code
In-Reply-To: <git-1267729916-5eb24b69c868ed8197842aa7c1576cdd05d9d41e@rmk-PC>
References: <git-1267729916-2dbb324ef24e91a11ed84389718874ece7056fd7@rmk-PC>
	<git-1267729916-5eb24b69c868ed8197842aa7c1576cdd05d9d41e@rmk-PC>
Message-ID: <000001cabc52$b2514090$16f3c1b0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King

> +	select PLAT_VERSATILE

This needs to be called something else if it's going to be used for
mach-realview and mach-integrator. It's too confusing because of there being
a mach-versatile. It needs to be a more generic name, something that isn't a
mach. Perhaps "ARMDEV".

Colin
