From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 May 2012 17:57:21 +0200
Subject: [PATCH v2] ARM: at91: add atmel-mci support for chips and
 boards which can use it
In-Reply-To: <4FC4AB4A.8060605@atmel.com>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
 <20120528074133.GR3377@game.jcrosoft.org>
 <4FC4AB4A.8060605@atmel.com>
Message-ID: <20120529155721.GS3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:56 Tue 29 May     , Nicolas Ferre wrote:
> On 05/28/2012 09:41 AM, Jean-Christophe PLAGNIOL-VILLARD :
> > On 12:23 Mon 21 May     , ludovic.desroches at atmel.com wrote:
> >> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>
> >> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
> >> use it instead of at91_mci driver.
> >>
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >> ---
> >> V2: add several boards I missed
> > for the 9g20 and 9260 please drop the old driver support too
> 
> No, we will drop the support for old driver when we finish the
> transition period. We will then drop at91_mci with all configuration
> data in device/board files.
on 9g20 and 9260 the new drivers is present for release

there is no reason to keep one more release

Best Regards,
J.
