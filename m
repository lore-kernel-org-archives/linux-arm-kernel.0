From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 19 Mar 2014 16:15:26 -0300
Subject: [PATCH 0/4] sunxi clock fixes
In-Reply-To: <20140319190418.30995.17661@quantum>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
 <20140319190418.30995.17661@quantum>
Message-ID: <5329ECCE.7010700@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 19/03/14 16:04, Mike Turquette escribi?:
> Quoting Emilio L?pez (2014-03-19 11:19:29)
>> Hi everyone,
>>
>> This is a small series of patches fixing a couple of bugs that are
>> present on the sunxi clock driver. Mike, are there any chances we can
>> take these during the 3.15 merge window or -rc period?
>
> I can take these towards 3.15. Do you want me to take the dts patch too?

I'd rather have Maxime take it to avoid potential conflicts. That patch 
can wait in any case; there's no actual pll4 consumer in tree just yet.

Cheers,

Emilio
