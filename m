From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 17 Jul 2015 23:49:40 +0200
Subject: [PATCH 2/5] clocksource: mediatek: Use GPT as sched clock source
In-Reply-To: <1436779969-18610-3-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436779969-18610-3-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1649653.yGMEJPDvvi@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 13, 2015 05:32:46 PM Yingjoe Chen wrote:
> When cpu is in deep idle, arch timer will stop counting. Setup GPT as
> sched clock source so it can keep counting in idle.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
