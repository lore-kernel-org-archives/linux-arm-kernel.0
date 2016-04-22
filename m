From: joel@jms.id.au (Joel Stanley)
Date: Fri, 22 Apr 2016 10:36:34 +0930
Subject: [PATCH v2 04/11] clocksource/moxart: Generalise timer for use on
 other socs
In-Reply-To: <4840688.ZUmiMtO0cR@wuerfel>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-5-git-send-email-joel@jms.id.au>
 <4840688.ZUmiMtO0cR@wuerfel>
Message-ID: <CACPK8Xcsk0vcb2hV7pVL4L=dvj7PHMg4V=Mk+r_w4bA9OQY0pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 5:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 April 2016 17:34:02 Joel Stanley wrote:
>> The moxart timer IP is shared with another soc made by Aspeed.
>
> Any idea where the IP block came from? Moxart contains a lot of
> licensed IP from faraday-tech. If this is one of them, we could
> maybe rename the driver accordingly.

Faraday would be a good bet, given that aspeed use their ethernet mac IP.

I'll ask around.

Cheers,

Joel
