From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 21 Jun 2012 11:10:23 +0200
Subject: [PATCH v6 00/14] add imx usb driver based on Greg next tree
In-Reply-To: <20120621085246.GC1582@b20223-02.ap.freescale.net>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <4FE2CC37.8010202@pengutronix.de>
 <20120621085246.GC1582@b20223-02.ap.freescale.net>
Message-ID: <4FE2E4FF.8030700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2012 10:52 AM, Richard Zhao wrote:
> On Thu, Jun 21, 2012 at 09:24:39AM +0200, Marc Kleine-Budde wrote:
>> On 06/21/2012 08:41 AM, Richard Zhao wrote:
>>> The work is based on  ci13xxx rework done by Alexander Shishkin.
>>>
>>> To let Greg pick up, I also added patches Alex queued that I depends on.
>>> Patch #1 - #9 : It can also be found at
>>> http://github.com/virtuoso/linux-ci.git ci
>>>
>>> This patch series can also be found at:
>>> https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
>>>
>>> Status:
>>>   - this version only support host
>>>   - usbotg controler works at host role
>>
>> I'm interested in usb device support on mx28, what has to be implemented
>> to get it working?
> I don't have patch yet, but on the plan.

What needs to be done? I want to help/implement it.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/b4d3e8b3/attachment.sig>
