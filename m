From: bp@suse.de (Borislav Petkov)
Date: Tue, 27 Jun 2017 18:27:22 +0200
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <3e07b9f0-b2e8-cfd8-9deb-76ed48a8f2c1@codeaurora.org>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
 <22ba6506-1031-437b-95ae-c26773ff84b7@huawei.com>
 <20170627072555.m5ogmljp7f6lf6fu@pd.tnic>
 <3e07b9f0-b2e8-cfd8-9deb-76ed48a8f2c1@codeaurora.org>
Message-ID: <20170627162722.g3ryqp423d6yfjcj@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 09:40:18AM -0600, Baicar, Tyler wrote:
> ... but there is obviously only one of those. That is something that may
> be easy to add to the arm_event TP...or do that in a separate TP as
> well.

See here:

https://lkml.kernel.org/r/20170626140647.anigiqhk3l6ltet7 at pd.tnic

for possible things you could do.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
