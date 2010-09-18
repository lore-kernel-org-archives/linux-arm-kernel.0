From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 18 Sep 2010 11:52:12 -0700
Subject: [00/12] DMAENGINE: PL08X driver updates
In-Reply-To: <AANLkTi==kKBdOaim+fx5yhpKOo27HWhB7kQiDqv0+BPS@mail.gmail.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi==kKBdOaim+fx5yhpKOo27HWhB7kQiDqv0+BPS@mail.gmail.com>
Message-ID: <AANLkTi=XH4_0UH8cN_uNzrTmf9GuASe32977gtgUVigU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 8, 2010 at 7:26 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/8/31 Linus Walleij <linus.walleij@stericsson.com>:
>
>> This updates the PL08X driver in the async_tx next branch with
>> a number of fixes and features, each one pretty self-describing.
>> This has been tested with the PrimeCell DMA series on the
>> RealView PB11MPCore and works flawlessly, multiplexing
>> several virtual clients, both devices (slaves) and memcpy
>> channels, across only two (!) available physical channels.
>
> Dan can you ACK and queue this for next?
>
> I know you're busy, just a reminder...
>

I'm back at work this coming week and will get all this queued up.

--
Dan
