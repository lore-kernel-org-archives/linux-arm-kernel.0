From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 11 Nov 2013 11:09:16 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFkZCBz?=
 =?UTF-8?B?dXBwb3J0IGZvciBpLk1YMjcvaS5NWDMxIENQVXM=?=
In-Reply-To: <528074C2.9070707@gtsys.com.hk>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1384148852.19743495@f117.i.mail.ru>
 <528074C2.9070707@gtsys.com.hk>
Message-ID: <1384153756.15403316@f304.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> >>>> On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
> >>>>> This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> >>>>>
> >>>>> Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> >>>>> ---
> >>>>>     drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
> >>>>>     1 file changed, 42 insertions(+)
...
> At this point might be good to patch the imx27.dtsi with the usb defines.
...

I have a working configuration for i.MX27 USB, but I prefer to make a few more
tests before the addition of definitions in DTS. This will be a next step.
Thanks.

---
