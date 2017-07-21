From: bp@suse.de (Borislav Petkov)
Date: Fri, 21 Jul 2017 08:00:07 +0200
Subject: [PATCH v5 1/1] acpi: apei: Enable APEI multiple GHES source to
 share an single external IRQ
In-Reply-To: <1500586563-7088-2-git-send-email-lho@apm.com>
References: <1500586563-7088-1-git-send-email-lho@apm.com>
 <1500586563-7088-2-git-send-email-lho@apm.com>
Message-ID: <20170721060007.GA26714@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:36:03PM -0700, Loc Ho wrote:
> This patch allows APEI generic error source table with external

"This patch" in a commit message is tautologically redundant.

> IRQ to share a single IRQ.

Because? More background please.

> Co-authored-by: Tuan Phan <tphan@apm.com>

I guess an invented tag is fine. What you can also do is say in free
text in the commit message that Tuan has helped.

> Signed-off-by: Loc Ho <lho@apm.com>
> ---

...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
