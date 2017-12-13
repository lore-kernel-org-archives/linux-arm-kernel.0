From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 13 Dec 2017 17:40:44 +0200
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <c41db747-757a-131f-14b6-e181403db007@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
 <1513073105.25007.618.camel@linux.intel.com>
 <bae16fa3-1bdf-74b1-97b7-f6b2db212621@codeaurora.org>
 <1513175535.7000.10.camel@linux.intel.com>
 <9c28bebb-5f57-83e8-9885-5262bbdc1b94@codeaurora.org>
 <c41db747-757a-131f-14b6-e181403db007@codeaurora.org>
Message-ID: <1513179644.7000.47.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-12-13 at 09:18 -0600, Timur Tabi wrote:
> On 12/13/2017 08:46 AM, Timur Tabi wrote:

> I think I found it.  Are you talking about doing this instead:
> 
> id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev-
> >dev);

Precisely!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
