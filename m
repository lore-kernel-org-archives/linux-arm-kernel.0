From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Sep 2012 15:55:00 +0200
Subject: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
In-Reply-To: <50473D92.9000500@pengutronix.de>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <50473D92.9000500@pengutronix.de>
Message-ID: <504759B4.6060203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
> On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
>> Adds suspend/resume functionality of d_can driver along with d_can
>> raminit support which is required to initialize RAM while data
>> transmission.
>>
>> This patch series also adds pinctrl support to c_can driver. These
>> patches were tested on AM335x-EVM.
>>
>> This patch-series is based ontop of runtimePM patch submitted
>> earlier - https://patchwork.kernel.org/patch/1348081/
> 
> Looks good, I'll apply the series after Tony acks the patch 3
> ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
> pass d_can raminit).

I've pushed all patches to can-next/master [1]. When Tony gives his Ack,
I'll send David a pull request (of a tree including that Ack).

Marc

[1] https://gitorious.org/linux-can/linux-can-next

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120905/05315798/attachment-0001.sig>
