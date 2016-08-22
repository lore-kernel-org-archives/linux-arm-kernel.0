From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 Aug 2016 19:31:53 +0200
Subject: [RESEND PATCH] soc: mediatek: PMIC wrap: Extend the waiting time
 to 10ms.
In-Reply-To: <1468380868-16683-1-git-send-email-henryc.chen@mediatek.com>
References: <1468380868-16683-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <83d5b8ac-3b6d-ae31-9dba-6146c1d3664a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/16 05:34, Henry Chen wrote:
> Read data fails sometimes because of a timeout that PMIC cannot transfer data
> to PMIC wrap on time, extend the waiting time to 10ms to reduce the failed
> rate.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---

Applied, thanks
