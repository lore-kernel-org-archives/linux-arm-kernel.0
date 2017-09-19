From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 19 Sep 2017 10:19:52 +0100
Subject: [PATCH 1/7] i2c: gpio: Convert to use descriptors
In-Reply-To: <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
 <20170918083629.qn4dlrmk7ffipfsz@dell>
 <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
Message-ID: <42702eb3-d1dd-5dd0-dbd6-ac163bcc27c2@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/17 20:00, Linus Walleij wrote:
> On Mon, Sep 18, 2017 at 10:36 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Sun, 17 Sep 2017, Linus Walleij wrote:
> 
>>> Lee: requesting ACK for Wolfram to take this patch.
>>
>> This ...
>>
>>> SM501 users: requesting Tested-by on this patch.
>>
>> ... loosely depends on this (until it doesn't).
> 
> Yeah I did my best to scout around the commit logs
> to figure out who's been contributing to the SM501 and
> using it, I hope someone will step up and test it.

I don't know if anything I have available working has an
SM501 on it. We did a couple of boards with S3C2440 and
an SM501 connected via external IO. However these have
not been supported in years (since Simtec)

I don't even think I have the PCI SM501 kit, that may have
ended up either at Simtec or one of the other engineers.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
