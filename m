From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 May 2012 09:41:33 +0200
Subject: [PATCH v2] ARM: at91: add atmel-mci support for chips and
 boards which can use it
In-Reply-To: <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120528074133.GR3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:23 Mon 21 May     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
> use it instead of at91_mci driver.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> V2: add several boards I missed
for the 9g20 and 9260 please drop the old driver support too

for calao bord you can do it too

Best Regards,
J.
