From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jan 2016 18:12:46 +0100
Subject: [PATCH v2 2/7] ARM: dts: kirkwood: gpio pin fixes for
 linkstation ls-wvl/vl
In-Reply-To: <1453304038-28345-3-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-3-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160120171246.GO28750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 12:33:53AM +0900, Roger Shimizu wrote:
> For kirkwood, gpio pins starts from 32 are in the 2nd bank, so it should be
> converted to "gpio1 <pin minus 32>" in dts file.
> e.g. gpio 40 should be "gpio1 8"
> 
> The pin/bank issue was found when discussing Debian Bug #810894
>   [https://bugs.debian.org/810894#47]
> 
> Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
> Reported-by: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Reviewd-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
