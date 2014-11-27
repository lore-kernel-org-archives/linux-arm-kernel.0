From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 27 Nov 2014 21:31:12 +0800
Subject: [PATCH v8 3/4] ARM: mediatek: Add sysirq in
 mt6589/mt8135/mt8127 dtsi
In-Reply-To: <1416902662-19281-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416902662-19281-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1417095072.12707.29.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-25 at 16:04 +0800, Yingjoe Chen wrote:
> Add sysirq settings for mt6589/mt8135/mt8127
> This also correct timer interrupt flag. The old setting works
> because boot loader already set polarity for timer interrupt.
> Without intpol support, the setting was not changed so gic
> can get the irq correctly.

Hi Matthias,

I think this patch should go through you. Would you take a look at this
patch? Also, mt8135/mt8127 uart support[1] depends on this, should we
send it again?

Thanks.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296147.html
