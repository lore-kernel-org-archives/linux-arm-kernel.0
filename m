From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Feb 2018 09:07:31 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation
 point
In-Reply-To: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
Message-ID: <7871181.EPqc8gR4GV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 13. Februar 2018, 10:44:32 CET schrieb Daniel Schultz:
> Rockchip recommends to run the CPU cores only with operations points of
> 1.6 GHz or lower.
> 
> Removed the cpu0 node with too high operation points and use the default
> values instead.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

applied all 3 for 4.17


Thanks
Heiko
