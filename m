From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Mar 2013 11:04:52 +0530
Subject: [PATCH 2/8] memory: emif: setup LP settings on freq update
In-Reply-To: <1362978365-5593-3-git-send-email-lokeshvutla@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
 <1362978365-5593-3-git-send-email-lokeshvutla@ti.com>
Message-ID: <513D6CFC.6080100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 March 2013 10:35 AM, Lokesh Vutla wrote:
> From: Ambresh K <ambresh@ti.com>
> 
> Program the power management shadow register on freq update
> Else the concept of threshold frequencies dont really matter
> as the system always uses the performance mode timing for LP
> which is programmed in at init time.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
