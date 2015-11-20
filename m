From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 11:29:22 +0100
Subject: [PATCH] drivers/built-in.o: In function `qcom_smp2p_intr':
In-Reply-To: <47507465.yGmu2TCElj@wuerfel>
References: <47507465.yGmu2TCElj@wuerfel>
Message-ID: <5085227.03pGgTygZ1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 10:43:00 Arnd Bergmann wrote:
> The newly added smp2p and smsm drivers cannot be loadable modules
> but depend on smem, which can be, and that causes a link error:
> 

Sorry, $SUBJECT is wrong, I'll resend.

	Arnd
