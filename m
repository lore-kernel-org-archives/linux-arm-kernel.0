From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 18 Dec 2015 15:06:06 -0800
Subject: [RESEND PATCH] mtd: mtk-nor: adjust sequence of trigger function
 and assignment function
In-Reply-To: <1450407760-30030-1-git-send-email-bayi.cheng@mediatek.com>
References: <1450407760-30030-1-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151218230606.GV10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:02:40AM +0800, Bayi Cheng wrote:
> Move write data register before excute command to avoid
> missing first byte write to nor flash
> 
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> ---
> the previous patch didn't drop the Change-Id

Applied to l2-mtd.git
