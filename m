From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 May 2014 09:38:03 +0200
Subject: [PATCH 1/4] edac: Fix MC scrub mode comparsion bug for
 correctable error
In-Reply-To: <1399590199-12256-2-git-send-email-lho@apm.com>
References: <1399590199-12256-1-git-send-email-lho@apm.com>
 <1399590199-12256-2-git-send-email-lho@apm.com>
Message-ID: <20140509073803.GD8844@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 05:03:16PM -0600, Loc Ho wrote:
> This patch fixes the MC scrub mode comparsion bug by replacing
> '&' with '=='. The MC structure field scrub_mode is integer
> type - not bit field.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
