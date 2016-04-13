From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 13:10:22 +0800
Subject: [PATCH 1/1] ARM: dts: ls1021a: DSPI has 6 chip-selects
In-Reply-To: <1458726546-29453-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1458726546-29453-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20160413051022.GJ28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 10:49:06AM +0100, Alexander Stein wrote:
> Both DSPI have signals SPIn_PCS[0:5] so in summary 6 chip-selects, not 5.
> Fix that.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied, thanks.
