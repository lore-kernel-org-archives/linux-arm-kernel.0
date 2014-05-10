From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 10 May 2014 18:25:56 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwLzZdIHVzYjogaG9zdDogQ2xlYW51cCBmb3IgaW9y?=
 =?UTF-8?B?ZW1hcCdpbmcgaGNkIG1lbW9yeQ==?=
In-Reply-To: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399731956.962771892@f256.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 10 May 2014 17:30:04 +0530 ?? Vivek Gautam <gautam.vivek@samsung.com>:
> Based on 'usb-next' branch of Greg's usb tree.
> 
> devm_ioremap_resource() API is advantageous over devm_ioremap()
> and should therefore be preferred to request any ioremap'ed address
> for hcd.
> 
> Changes from v1:
>  - Changed the way returned pointer is checked for error value
>    as pointed out in the review comment in the mailing list.

hcd->rsrc_len field can be removed entirely, since I cannot find any reason
how this filed can be used in the drivers now.
This is of course should be in an another series. This one looks good.

---
