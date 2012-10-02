From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 02 Oct 2012 14:59:05 -0700
Subject: [PATCH 1/2] ARM: OMAP: SmartReflex: fix error path in init
 function
In-Reply-To: <1348496201-6378-2-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Mon, 24 Sep 2012 16:16:40 +0200")
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
 <1348496201-6378-1-git-send-email-j-pihet@ti.com>
 <1348496201-6378-2-git-send-email-j-pihet@ti.com>
Message-ID: <87vces7cye.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Fix the error handling path in omap_sr_probe to correctly
> de-allocate resources in case of problems.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Thanks, queuing this one as a fix for v3.7-rc

Kevin
