From: davem@davemloft.net (David Miller)
Date: Tue, 31 Jan 2012 16:18:02 -0500 (EST)
Subject: [PATCH 1/1] net: fec: correct phy_name buffer length when init
 phy_name
In-Reply-To: <1327910892-11251-1-git-send-email-richard.zhao@linaro.org>
References: <1327910892-11251-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120131.161802.213839339147145725.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>
Date: Mon, 30 Jan 2012 16:08:12 +0800

> Fix the bug that we got wrong phy_name on imx6q sabrelite board.
> snprintf used wrong length of phy_name.
> phy_name length is MII_BUS_ID_SIZE + 3 rather not MII_BUS_ID_SIZE.
> I change it to sizeof(phy_name).
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

Applied, thanks.
