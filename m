From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 14 Mar 2016 08:44:08 +0100 (CET)
Subject: [PATCH v2 2/2] Irq/mbigen:Change the mbigen driver based on the
 new mbigen node definition.
In-Reply-To: <1457937907-14008-3-git-send-email-majun258@huawei.com>
References: <1457937907-14008-1-git-send-email-majun258@huawei.com>
 <1457937907-14008-3-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1603140841560.3657@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Mar 2016, MaJun wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> To fix the IO remap problem, change the mbigen driver based on the
> new mbigen node definition.

Please describe what the problem is. There is no way that anyone can figure
out why that patch is required, what it fixes and how the fix is done. The
'how' should be a high level description as we can see the actual changes in
the diff.

Thanks,

	tglx

 
