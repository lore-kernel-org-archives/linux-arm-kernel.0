From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 18 Sep 2013 11:04:32 +0200
Subject: [PATCH 1/2] ARM: dts: Fix muxing and regulator for wl12xx on
 the SDIO bus for pandaboard
In-Reply-To: <20130918000203.GS9994@atomide.com>
References: <20130913190811.24617.97699.stgit@localhost>
 <20130913190953.24617.46506.stgit@localhost>
 <1379399214.4223.123.camel@porter.coelho.fi>
 <1379399290.4223.124.camel@porter.coelho.fi>
 <20130918000203.GS9994@atomide.com>
Message-ID: <52396CA0.6030100@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 18/09/2013 02:02, Tony Lindgren wrote:
> * Luca Coelho <luca@coelho.fi> [130916 23:35]:
>> On Tue, 2013-09-17 at 09:26 +0300, Luca Coelho wrote:
>>> Both patches look good to me, though I didn't have the time to retest
>>> them.
>>
>> Actually I don't even have a Blaze device anymore, so I can't really
>> test the second patch. :(
>
> OK no problem, I've tested it on panda es.

Do we have someone out-there that still own a Blaze?

Anyway, I'm about to send a DTS fix branch for -rc2, so I'll include 
these two patches.

Thanks,
Benoit
