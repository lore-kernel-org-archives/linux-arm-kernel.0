From: xjq@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 10:06:38 +0800
Subject: [PATCH 2/5] ASoC: rockchip-i2s: fix master mode set bit error
In-Reply-To: <20140913163501.GH7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568863-21723-1-git-send-email-jay.xu@rock-chips.com>
 <20140913163501.GH7960@sirena.org.uk>
Message-ID: <5414F82E.9090004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/14/2014 12:35 AM, Mark Brown ??:
> On Sat, Sep 13, 2014 at 08:41:03AM +0800, Jianqun wrote:
>> Fix error format set to I2S master or slave mode.
>> Test on RK3288 board with max98090.
> 
> Applied.  Since this is a bug fix it should be one of the first patches
> in the series so that it can be sent to Linus as a fix, bug fixes should
> go before any other patches.
> 

got it, I'll do it at new version patch, thanks 
