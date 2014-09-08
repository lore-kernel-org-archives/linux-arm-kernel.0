From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 8 Sep 2014 09:53:09 +0530
Subject: [PATCH v6 4/4] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <20140905175651.GK24449@saruman.home>
References: <1409656338-20337-1-git-send-email-gautam.vivek@samsung.com>
 <1409656338-20337-5-git-send-email-gautam.vivek@samsung.com>
 <20140902143438.GB16872@saruman.home>
 <CAFp+6iEyqmbwMLFrBKD7NVLDAC=b+h1hPKFS=BG4k9D69hn_dg@mail.gmail.com>
 <20140903144225.GD31855@saruman.home>
 <CAFp+6iETPJCWMMkjHrpDcdCv=K0PbefYLa4eBOwN=aUY2=EHLA@mail.gmail.com>
 <20140905175651.GK24449@saruman.home>
Message-ID: <CAFp+6iGU86yL8Ry3ArJJjBy2Cs0Em2B49yssH3BK5fJwyaZbtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 5, 2014 at 11:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Sep 04, 2014 at 12:01:19PM +0530, Vivek Gautam wrote:
>> > Don't we have phy_power_on()
>> > for that ? It looks like you could just as well do this from
>> > phy_power_on() ?
>>
>> No, unfortunately keeping these calibration settings in phy_power_on()
>> doesn't help, since we need to do this after XHCI reset has happened.
>
> teach xHCI about PHYs ?

sorry i couldn't understand you here.
Aren't we trying to do the same with Heikki's patch about dwc3 :
[PATCH 6/6] usb: dwc3: host: convey the PHYs to xhci

and the 2nd patch in this series :
[PATCH v6 2/4] usb: host: xhci-plat: Get PHYs for xhci's hcds

Is there something else that is expected ?




-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
