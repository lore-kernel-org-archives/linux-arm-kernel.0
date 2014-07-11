From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 11 Jul 2014 02:38:00 +0000
Subject: [PATCH] tty: serial: fsl_lpuart: add 32-bit register interface
 support
In-Reply-To: <20140710230353.GA25661@kroah.com>
References: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
 <20140710230353.GA25661@kroah.com>
Message-ID: <d2f73b90bc714108a9aa14824633b375@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Greg KH [mailto:gregkh at linuxfoundation.org]
>Sent: Friday, July 11, 2014 7:04 AM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH] tty: serial: fsl_lpuart: add 32-bit register
>interface support
>
>On Tue, Jul 01, 2014 at 04:43:46PM +0800, Jingchang Lu wrote:
>> This add the big-endian 32-bit register version LPUART support.
>>
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>  drivers/tty/serial/fsl_lpuart.c | 652
>> +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 643 insertions(+), 9 deletions(-)
>
>This patch fails to apply to my tree :(
>
>Can you refresh it against the tty-next branch of the tty.git tree on
>git.kernel.org and resend?
Yes, I will do that and resend the patch. Thanks.



Best Regards,
Jingchang
