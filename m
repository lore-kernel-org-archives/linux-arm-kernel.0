From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Sep 2016 17:48:39 +0200
Subject: [PATCH v5 2/4] ARM: dts: rockchip: update compatible strings for
 Rockchip efuse
In-Reply-To: <1472786217-52214-3-git-send-email-finley.xiao@rock-chips.com>
References: <1472786217-52214-1-git-send-email-finley.xiao@rock-chips.com>
 <1472786217-52214-3-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <18429499.x7qIytyN63@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. September 2016, 20:16:55 schrieb Finley Xiao:
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

due to the new compatible values, this would cause a regression (existing 
functionality breaking) when used without the efuse change, so I've put this 
patch into a branch for 4.10 with Doug's review, so that the code change is 
definitly existing by then.


Heiko
