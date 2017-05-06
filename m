From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 06 May 2017 22:51:25 +0800
Subject: [PATCH v2] clk: sunxi-ng: v3s: Fix usb otg device reset bit
In-Reply-To: <20170505200440.zje5s7x2seglxzi6@lukather>
References: <1493980317-39775-1-git-send-email-iemdey@gmail.com>
 <20170505200440.zje5s7x2seglxzi6@lukather>
Message-ID: <a7ef1477b9dec8009e9c40bce5d42267@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-06 04:04?Maxime Ripard ???
> Hi,
> 
> On Fri, May 05, 2017 at 06:31:57PM +0800, Yong Deng wrote:
>> V3S's usb otg device reset bit should be 24, not 23.
>> 
>> Signed-off-by: Yong Deng <iemdey@gmail.com>
>> Reviewed-By: Icenowy Zheng <icenowy@aosc.io>
> 
> Applied, thanks.
> Maxime

Maybe it should also apply to 4.11 stable?

Cc: stable at vger.kernel.org
