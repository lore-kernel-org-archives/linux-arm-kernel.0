From: xjq@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 10:29:50 +0800
Subject: [PATCH] ASoC: rockchip-i2s: dt: swap tx and rx channed request
 number
In-Reply-To: <20140913164032.GN7960@sirena.org.uk>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
 <20140913164032.GN7960@sirena.org.uk>
Message-ID: <5414FD9E.4000602@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/14/2014 12:40 AM, Mark Brown ??:
> On Sat, Sep 13, 2014 at 09:04:41AM +0800, Jianqun wrote:
>> Reference to RK3288 TRM, fix an error channel id for i2s tx and rx
>> Table 10-1 DMAC_BUS Request Mapping Table
>> Req number	Source	Polarity
>> 0		I2S tx	High level
>> 1		I2S rx	High level
> 
> Applied, thanks.  The changelog should've just noted that this is an
> error in the example rather than the code or the binding, I was a bit
> confused about this.
> 
ok, I will do it
