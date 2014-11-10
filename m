From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 10 Nov 2014 12:33:15 -0800
Subject: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
In-Reply-To: <20141110193931.GN3815@sirena.org.uk>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <7hr3xerdw6.fsf@deeprootsystems.com> <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
 <20141110183224.GA5626@dtor-ws> <20141110193931.GN3815@sirena.org.uk>
Message-ID: <F09FA55F-7246-4E9F-B54D-7CB984E10161@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On November 10, 2014 11:39:31 AM PST, Mark Brown <broonie@kernel.org> wrote:
>On Mon, Nov 10, 2014 at 10:32:24AM -0800, Dmitry Torokhov wrote:
>
>> - I do not see why sirincling platform specific code around i2c, spi,
>>   etc bus code (which is not platform-specific) is OK, but a no-no
>for
>>   the driver ocre.
>
>sirincling?

Sorry, I was going for "sprinkling" but failed spectacularly.


Thanks.

-- 
Dmitry
