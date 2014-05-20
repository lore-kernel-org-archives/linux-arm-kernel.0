From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 20 May 2014 13:42:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxOC8yMF0gQVJNOiBpbXg1OiByZW1vdmUgZmlsZSBtbS1p?=
 =?UTF-8?B?bXg1LmM=?=
In-Reply-To: <1400575538-21136-19-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
 <1400575538-21136-19-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400578975.608551061@f382.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 20 May 2014 16:45:36 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> The only code left in mm-imx5.c is to create static mapping.  While all
> IMX platform code are moved to use dynamic mapping, the file can just be
> removed now.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Do we need a static mappings for UART lowlevel debug?

---
