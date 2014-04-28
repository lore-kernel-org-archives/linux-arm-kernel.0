From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 28 Apr 2014 09:55:31 +0200
Subject: [PATCH 4/6] drivers: net: cpsw: Enable Annexe F Time sync
In-Reply-To: <1398658225-25873-5-git-send-email-george.cherian@ti.com>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-5-git-send-email-george.cherian@ti.com>
Message-ID: <20140428075530.GA8371@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:40:23AM +0530, George Cherian wrote:
> Enable the Annex F Time Sync explicitly for DRA7x and AM4372.
> With this enabled the L2 PTP is working.

L2 works fine without this bit. If this is needed for V3 hardware,
then it should have its own code variant.
 
> while at that rename TS_BIT8 to TS_TTL_NONZERO

Is this bit finally documented for am335x?

Thanks,
Richard
