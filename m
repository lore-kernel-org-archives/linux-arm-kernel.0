From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Aug 2018 18:49:51 +0200
Subject: [PATCH v1 1/7] From: Ken Ma <make@marvell.com>
In-Reply-To: <20180808152706.21727-2-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-2-marek.behun@nic.cz>
Message-ID: <20180808164951.GI7275@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 05:27:00PM +0200, Marek Beh?n wrote:
> pinctrl: armada-37xx: Correct mpp definitions

Hi Marek

The subject line is messed up.

> 
> This patch corrects below mpp definitions:
>  - The sdio_sb group is composed of 6 pins and not 5;
>  - The rgmii group contains pins mpp2[17:6] and not mpp2[19:6];
>  - Pin of group "pmic0" is mpp1[6] but not mpp1[16];
>  - Pin of group "pmic1" is mpp1[7] but not mpp1[17];
>  - A new group "smi" is added in A0 with 2 pins - mpp2[19:18], its
>    bitmask is bit4;
>  - Group "pcie1" has 3 pins in A0 - mpp2[5:3], its bit mask is
>    bit5 | bit9 | bit10 but not bit4;
>  - Group "ptp" has 3 pins in A0 as Z1, but its bitmask is changed to
>    bit11 | bit12 | bit13.
> 
> Signed-off-by: Marek Behun <marek.behun@nic.cz>

This probably should should have the original Marvell SOB as well.

     Andrew
