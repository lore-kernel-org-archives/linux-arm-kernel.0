From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 31 May 2018 12:20:48 +0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <20180530173414.6121-1-andrew.smirnov@gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
Message-ID: <49e934d8-228a-35b1-8db2-0402422916fa@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
> imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
> well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
> exhibits a kernel frozen on PORTSC access and applying the workaround
> resolves the issue.

Confirmed on 8.9'' RDU1

Tested-By: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
