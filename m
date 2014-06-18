From: bp@alien8.de (Borislav Petkov)
Date: Thu, 19 Jun 2014 00:10:46 +0200
Subject: [PATCH v3 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1401761660-11515-4-git-send-email-lho@apm.com>
References: <1401761660-11515-1-git-send-email-lho@apm.com>
 <1401761660-11515-2-git-send-email-lho@apm.com>
 <1401761660-11515-3-git-send-email-lho@apm.com>
 <1401761660-11515-4-git-send-email-lho@apm.com>
Message-ID: <20140618221046.GL24024@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 08:14:19PM -0600, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver and
> requires ARM64 EDAC support patch [1] to compile.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg324093.html
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>

This is starting to look ok, I'd guess it needs to go after the atomic
scrub patch goes in, right?

Also, I'd need the device tree pieces acked by device tree maintainers
before I pick them up together with this driver.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
