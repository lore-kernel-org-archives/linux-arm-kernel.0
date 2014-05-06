From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 6 May 2014 23:10:41 +0200
Subject: [PATCH] rtc: rtc-at91rm9200: fix infinite wait for ACKUPD irq
In-Reply-To: <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com>
References: <94c06375c1b44c8eb5233b0ccf2e4b13@BY2PR05MB048.namprd05.prod.outlook.com>
 <1399386481-18643-1-git-send-email-boris.brezillon@free-electrons.com>
 <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com>
Message-ID: <20140506211040.GF11243@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/05/2014 at 19:06:56 +0000, Bryan Evenson wrote :
> 
> I'd assume this patch would be backported to the longterm releases?
> 

If by longterm, you mean the linux4sam tree, 3.10 branch, it is up to
Nicolas to take it. I believe it will be pretty easy to convince him ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
