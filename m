From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 10 Oct 2014 06:16:24 +0000
Subject: [PATCH] serial: of-serial: fix up PM ops on no_console_suspend
In-Reply-To: <543768F3.6090703@wwwdotorg.org>
References: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
 <543768F3.6090703@wwwdotorg.org>
Message-ID: <01583b7f252b4f81a5655009f6f73aba@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Stephen Warren [mailto:swarren at wwwdotorg.org]
>Sent: Friday, October 10, 2014 1:05 PM
>To: Lu Jingchang-B35083; gregkh at linuxfoundation.org
>Cc: arnd at arndb.de; Joseph Lo; linux-kernel at vger.kernel.org; linux-
>serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH] serial: of-serial: fix up PM ops on
>no_console_suspend
>
>On 10/09/2014 02:10 AM, Jingchang Lu wrote:
>> Mandatorily disabling the uart clock will cause register access hung
>> on "no_console_suspend". This patch add condition check on it and only
>> disable the clock with console_suspend_enabled true.
>
>It would be useful if the email/patch subject line said "V2", and there
>was a changelog below.
This is not a v2, patch "serial: of-serial: add PM suspend/resume support
(commit 2dea53bf57783f243c892e99c10c6921e956aa7e)" has been merged into
linux-next tree, this is a fixup on that PM ops.
Thanks.

Best Regards,
Jingchang 
