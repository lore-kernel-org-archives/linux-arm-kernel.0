From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 18 Oct 2016 11:34:24 +0300
Subject: =?UTF-8?B?UmU6IDQuNy42LT40LjguMSBQb3NzaWJsZSByZWdyZXNzaW9u?=
In-Reply-To: <20161017181051.GI1041@n2100.armlinux.org.uk>
References: <1476722858.483756177@f140.i.mail.ru>
 <20161017181051.GI1041@n2100.armlinux.org.uk>
Message-ID: <1476779664.727148998@f305.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????????, 17 ??????? 2016, 21:10 +03:00 ?? Russell King - ARM Linux <linux@armlinux.org.uk>:
>
>On Mon, Oct 17, 2016 at 07:47:38PM +0300, Alexander Shiyan wrote:
>> Hello.
>> 
>> After a kernel update from 4.7.6 to 4.8.1, the bug appear once kernel run "init".
>
>Please try this patch, thanks:
>
>diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
>index 6d8e8e3365d1..e81d09f1887d 100644
>--- a/arch/arm/mm/abort-lv4t.S
>+++ b/arch/arm/mm/abort-lv4t.S
...

Yes, this helps, thanks!

Tested-by: Alexander Shiyan <shc_work@mail.ru>

---
