From: xjq@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 10:24:00 +0800
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
In-Reply-To: <20140913163648.GJ7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
 <20140913163648.GJ7960@sirena.org.uk>
Message-ID: <5414FC40.1040005@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/14/2014 12:36 AM, Mark Brown ??:
> On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
>> As "hclk" is used for rockchip I2S controller, driver must to enable
>> it in probe.
> 
> Applied, again this is a bug fix.  How did the original submission get
> tested?
> 
The original submission is verified on rk3288 with kernel 3.10, but I had to make patches based on
kernel 3.14 +, also our sdk kernel has intalized the kernel in other ways, so I missed the enable but
the driver worked well.

The new patches is verified on kernel 3.14, so it will easy to test.
