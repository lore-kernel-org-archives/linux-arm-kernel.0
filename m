From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Dec 2013 21:11:40 +0100
Subject: [PATCH V2 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <1387594651-25771-1-git-send-email-rapatel@apm.com>
References: <1387594651-25771-1-git-send-email-rapatel@apm.com>
Message-ID: <201312212111.40576.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 December 2013, Ravi Patel wrote:
> This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
>  QMTM is required by APM X-Gene SoC Ethernet, PktDMA (XOR Engine) and
>  Security Engine subsystems. All subsystems communicate with QMTM using
>  messages which include information about the work to be performed and
>  the location of associated data buffers.  

Please describe here what the purpose of the qmtm is, as this is not
entirely clear from the code.

In particular, please describe how this differs from a dmaengine driver
and why it is not possible to extend the dma slave API to describe qmtm
as a dma engine.

	Arnd
