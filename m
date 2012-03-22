From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 22 Mar 2012 15:13:45 +0100
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F6B25A4.4090006@mvista.com>
References: <4F683B36.8090101@metasoft.pl> <4F6A78ED.3050403@gmail.com>
 <4F6AF845.9070209@metasoft.pl> <4F6B25A4.4090006@mvista.com>
Message-ID: <4F6B3399.2010501@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-22 14:14, Sergei Shtylyov wrote:
>    IDE or libata driver? Asking because IDE drivers are not accepted anymore.

Libata. Basically, it's the driver posted by Bartlomiej Zolnierkiewicz with
some changes (the most important being UDMA support).
