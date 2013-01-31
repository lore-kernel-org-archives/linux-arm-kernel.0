From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 31 Jan 2013 17:15:50 +0400
Subject: =?UTF-8?B?UXVlc3Rpb246IFdheSB0byBhZGQgbWlzc2luZyBwYWRzICYgcGlucyBpbnRv?=
 =?UTF-8?B?IHBpbmN0cmwgZHJpdmVy?=
Message-ID: <1359638150.473297558@f28.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I have found some missing pads and pins definitions in the pinctrl-imx51 driver.
Appending in sort order will break current devicetree configurations, so I want
to know better way for add these definitions. Of course I can just append
at the end, but this will break sort order. How to do it better?
Thanks.

---
