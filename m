From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 10 Aug 2010 11:28:17 +0100
Subject: [PATCH v2] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <4C612856.6090405@einfochips.com>
References: <1281428973-28957-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<20100810085643.GE21175@chipmunk> <20100810085821.GF21175@chipmunk>
	<4C612856.6090405@einfochips.com>
Message-ID: <20100810102817.GJ21175@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> [2010-08-10 15:52:14+0530]:
>
> Intention here is to provide SD support by default. It will be switched  
> to UART mode only if someone asks to do so via kernel parameter. If  
> someone doesn't give OR gives improper kernel parameter, he/she won't get 
> UART1. It will simply fall-back to the default setting - which is SD  
> support.
>
My mis-type, I forgot to put a 
'kirkwood_sdio_init(&openrd_mvsdio_data);' after my added printk().

Cheers

-- 
Alexander Clouter
.sigmonster says: BOFH excuse #367:
                  Webmasters kidnapped by evil cult.
