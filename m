From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 17 Oct 2014 08:46:24 -0400
Subject: [PATCH v1] tty: serial: 8250_core: restore the LCR register in
 set_sleep
In-Reply-To: <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
 <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
Message-ID: <54410FA0.6000903@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 08:39 AM, Sudhir Sreedharan wrote:
> In ST16650V2 based serial uarts, while initalizing the PM state,
> LCR registers are being initialized to 0 in serial8250_set_sleep().
> If console port is already initialized and being used, this will
> throws garbage in the console.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
