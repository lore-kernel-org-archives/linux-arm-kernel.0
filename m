From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Jan 2018 20:10:24 +0100
Subject: [PATCH 4/4 v7] drm/pl111: Support handling bridge timings
In-Reply-To: <1a2f8244-5436-5c65-7e9e-cfe2aa257d2e@codeaurora.org>
References: <20180112074854.9560-1-linus.walleij@linaro.org>
 <20180112074854.9560-4-linus.walleij@linaro.org>
 <1a2f8244-5436-5c65-7e9e-cfe2aa257d2e@codeaurora.org>
Message-ID: <CACRpkdbRWdWYXq-0K9ufFrzSg7iCP=dEm1NfrUaS1iGynAJ0Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 10:25 AM, Archit Taneja <architt@codeaurora.org> wrote:
> On 01/12/2018 01:18 PM, Linus Walleij wrote:
>>
>> If the bridge has a too strict setup time for the incoming
>> signals, we may not be fast enough and then we need to
>> compensate by outputting the signal on the inverse clock
>> edge so it is for sure stable when the bridge samples it.
>>
>> Since bridges in difference to panels does not expose their
>> connectors, make the connector optional in the display
>> setup code.
>>
>
> Since Eric has already Ack'ed it, queued to drm-misc-next so that
> the commits stay together.

Thanks man!

I have commit access but this is fine too, it's a bit like an
definitive external ACK :)

Yours,
Linus Walleij
