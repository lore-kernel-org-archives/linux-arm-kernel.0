From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 May 2017 19:57:02 +0200
Subject: [PATCH V2  2/2] clk: rockchip: fix the incorrect ids
In-Reply-To: <1493102470-22965-3-git-send-email-eddie.cai.linux@gmail.com>
References: <1493102470-22965-1-git-send-email-eddie.cai.linux@gmail.com>
 <1493102470-22965-3-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <1707274.tv1fl5P7jF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 25. April 2017, 14:41:10 CEST schrieb Eddie Cai:
> the ids of clk_testout1 and clk_testout2 is incorrect now. let's correct it
> 
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>

applied for 4.13, after fixing the subject up a bit [the old ids are not
incorrect, there simply weren't any assigned to the testclks yet :-) ]


Thanks
Heiko
