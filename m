From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 Aug 2017 01:13:25 +0200
Subject: [PATCH] arm64: dts: rk3399: init vop clock rates
In-Reply-To: <1502851869-1736-1-git-send-email-kever.yang@rock-chips.com>
References: <1502851869-1736-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <3118300.aNFzDAHPf8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. August 2017, 10:51:09 CEST schrieb Kever Yang:
> We need to init vop aclk and hclk incase the U-Boot does not do
> the initialize.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

applied for 4.14 with Marks review-tag after adapting the patch subject
and moving the properties slight higher


Thanks
Heiko
