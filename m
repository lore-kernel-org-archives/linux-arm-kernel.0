From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 17 Aug 2013 10:19:20 +0800
Subject: [PATCH RESEND] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <52049C44.6030902@pengutronix.de>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
 <52049C44.6030902@pengutronix.de>
Message-ID: <520EDDA8.6050309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 03:37 PM, Marc Kleine-Budde wrote:
> On 08/08/2013 02:00 PM, Alexander Shiyan wrote:
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> ---
>>   arch/arm/mach-pxa/icontrol.c         |  3 --
>>   arch/arm/mach-pxa/zeus.c             | 46 ++++++++++----------
>
> What's pxa's status of DT conversion? Do you (still) accept patches to
> board files?
>
> Marc
>

Since DT conversion isn't finished, I still accept the board files.
But this patch should be split into two parts. One is for pxa, and the
other one is for net.

Regards
Haojian
