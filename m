From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Thu, 22 Dec 2011 13:08:12 +0200
Subject: [PATCH v2 1/7 v2] ARM: OMAP1: ams-delta: register latch dependent
 devices later
In-Reply-To: <201112221139.16317.jkrzyszt@tis.icnet.pl>
References: <201112200028.32947.jkrzyszt@tis.icnet.pl>
 <201112212051.13113.jkrzyszt@tis.icnet.pl>
 <20111221200728.GG24444@atomide.com>
 <201112221139.16317.jkrzyszt@tis.icnet.pl>
Message-ID: <4EF30F9C.7030708@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2011 12:39 PM, Janusz Krzysztofik wrote:

>>> Don't we need Jarkko's or Mark's or Liam's ack as well for the change to
>>> the sound/soc/omap/ams-delta.c file?
>>
>> Yes, you're right.
>
> Jarkko, Mark or Liam, care to ack this change, moving the Amstrad Delta
> sound card registration to late_initcall?
>
Unfortunately I haven't had time to look at the series but I'm fine with 
sound/soc/omap/ams-delta.c change.

-- 
Jarkko
