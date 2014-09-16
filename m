From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 16 Sep 2014 12:00:45 -0700
Subject: [PATCH v3] ARM: apq8064: Add pinmux and i2c pinctrl nodes
In-Reply-To: <1410871001.891126377@apps.rackspace.com>
References: <1409052645-14984-1-git-send-email-kiran.padwal@smartplayin.com>
 <20140916023922.GB2386@qualcomm.com>
 <1410871001.891126377@apps.rackspace.com>
Message-ID: <96034F94-3C6D-43FC-95EF-7FA705724F99@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 16, 2014, at 5:36 AM, kiran.padwal at smartplayin.com wrote:

> 
> 
> On Monday, September 15, 2014 10:39pm, "Andy Gross" <agross@codeaurora.org> said:
> 
>> On Tue, Aug 26, 2014 at 05:00:45PM +0530, Kiran Padwal wrote:
>>> This patch adds pinmux and i2c pinctrl DT node for IFC6410 board.
>>> It also adds necessary DT support for i2c eeprom which is present on
>>> IFC6410.
>>> 
>>> Tested on IFC6410 board.
>> 
>> Looks fine
> 
> Thanks for review.

Can you rebase this on:

 git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-3.18

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
