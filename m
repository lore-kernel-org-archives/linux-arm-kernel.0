From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Jan 2016 01:37:06 +0100
Subject: [PATCH v2 7/7] ARM: dts: kirkwood: split lswvl dts to
 linkstation lsvl and lswvl
In-Reply-To: <1453304038-28345-8-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-8-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160121003706.GG22797@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 12:33:58AM +0900, Roger Shimizu wrote:
> LS-WVL/VL are both kirkwood-6282 based NAS devices, which share
> many MPP pins. However they are slightly different:
>   - LS-WVL is 2-Bay NAS, and LS-VL is only 1-Bay.
>   - There're two red LED indicator on LS-WVL to show when HDD fails,
>     which is similar to LS-WXL, but there's no such on LS-VL.
> 
> So after the split, common part goes into .dtsi file:
>   - kirkwood-linkstation-6282.dtsi
> while all rest part goes into device specific .dts file:
>   - kirkwood-linkstation-lsvl.dts
>   - kirkwood-linkstation-lswvl.dts
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	    Andrew
