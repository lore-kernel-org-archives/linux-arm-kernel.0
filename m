From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 04 Jan 2018 18:04:35 +0200
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <8e985f68-5887-b0d5-8c45-e22b5d8f60cf@codeaurora.org>
References: <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
 <20171220022626.GH7997@codeaurora.org>
 <d511f096-bad4-c7b3-d7d4-11b1fa3b1cce@codeaurora.org>
 <20171220081556.GA30524@codeaurora.org>
 <a5809701-3f81-3f79-f558-a831ce4091c2@codeaurora.org>
 <20171221003947.GJ7997@codeaurora.org>
 <38463c81-eeab-85dc-d197-6081ce1d1130@codeaurora.org>
 <20171222014633.GD7997@codeaurora.org>
 <8e985f68-5887-b0d5-8c45-e22b5d8f60cf@codeaurora.org>
Message-ID: <1515081875.7000.683.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-04 at 09:46 -0600, Timur Tabi wrote:
> On 12/21/2017 07:46 PM, Stephen Boyd wrote:
> > 
> > Maybe future HIDs could follow the DT design and then we can look
> > for the same device property name in both firmwares. 
> 
> DSDs generally don't have the vendor prefix that DT properties do.

There are more means to check hardware revisions:
HID - Hardware ID
CID - Compatible ID
UID - Unique ID (good to distinguish instances of the same device on the
board)
_HRV - Hardware Revision (6.1.6 describes this one)

Everything is described in the spec. Does anybody care to read?

P.S. More I reading this thread more I become thinking that people screw
ACPI use in many ways...

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
