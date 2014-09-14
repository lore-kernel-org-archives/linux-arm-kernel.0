From: xjq@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 10:20:11 +0800
Subject: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of
 rockchip i2s controller
In-Reply-To: <20140913163613.GI7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
 <20140913163613.GI7960@sirena.org.uk>
Message-ID: <5414FB5B.8090907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/14/2014 12:36 AM, Mark Brown ??:
> On Sat, Sep 13, 2014 at 08:42:12AM +0800, Jianqun wrote:
>> Reference rockchip I2S controller TRM, modify some registers' property
>> I2S_FIFOLR: read / write, but not volatile, not precious
>> I2S_INTSR: read / write
>> I2S_CLR: volatile, register value will be cleared by read
> 
> Applied, again this is a bug fix (volatile and precious being wrong seem
> like bugs) so should have been earlier in the series.
> 
ok, I'll re-order the patches
