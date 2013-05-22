From: b32955@freescale.com (Huang Shijie)
Date: Wed, 22 May 2013 16:16:19 +0800
Subject: [PATCH 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <20130521054323.GE3080@S2101-09.ap.freescale.net>
References: <1369039742-10893-1-git-send-email-b32955@freescale.com>
 <1369039742-10893-2-git-send-email-b32955@freescale.com>
 <20130521054323.GE3080@S2101-09.ap.freescale.net>
Message-ID: <519C7ED3.3030004@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?21? 13:43, Shawn Guo ??:
> It seems we can find it out from "reg" property, so that we can save
> this property?
>
we may have several devices attaching to the weim, each device has its 
own CS index.
it's better to keep this property, make it more clear.

thanks
Huang Shijie
