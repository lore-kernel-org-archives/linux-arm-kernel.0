From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Dec 2013 14:34:54 +0800
Subject: [PATCH v6 14/15] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <20131213043838.GI867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-15-git-send-email-peter.chen@freescale.com>
 <20131213043838.GI867@saruman.home>
Message-ID: <CAL411-p+9vEMjnCLaydFwo_EnadHS84qv2oso9XoEQRq1m6DgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:38 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 13, 2013 at 09:23:44AM +0800, Peter Chen wrote:
>> +SIMPLE_DEV_PM_OPS(mxs_phy_pm, mxs_phy_system_suspend, mxs_phy_system_resume);
>
> should be static.
>

Will change.

-- 
BR,
Peter Chen
