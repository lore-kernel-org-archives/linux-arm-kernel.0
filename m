From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 16:30:29 +0200
Subject: [PATCH v2 1/3] ARM: at91: use chipid device for soc detection
In-Reply-To: <1459260638-3899-1-git-send-email-nicolas.ferre@atmel.com>
References: <55618572.U3p4crGV1Y@wuerfel>
 <1459260638-3899-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <3656574.4DhkCSPNfU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 16:10:38 Nicolas Ferre wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> So far, the CIDR and EXID registers were in the DBGU interface. This device
> has disappeared with the SAMA5D2 family. These registers are exposed
> through a new device called chipid.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> [nicolas.ferre at atmel.com: remove useless warnings]
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> [arnd at arndb.de: suggest to use static functions to reduce scope]
> 

(whole series)

Acked-by: Arnd Bergmann <arnd@arndb.de>
