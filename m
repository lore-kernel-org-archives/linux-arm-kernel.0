From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 08:54:14 +0100
Subject: [PATCH 4/7] gpiolib: return any error code from range creation
In-Reply-To: <50ABBDCF.3080309@wwwdotorg.org>
References: <1353420282-18066-1-git-send-email-linus.walleij@stericsson.com>
 <50ABBDCF.3080309@wwwdotorg.org>
Message-ID: <CACRpkdYdPFQFgVZahBU7oT9JwrPEmsNNjXQ4NpLVUzwqADTyVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 6:28 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/20/2012 07:04 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> If we try to create a range for a certain GPIO chip and the
>> target pin controller is not yet available it may return
>> a probe deferral error code, so handle this all the way
>> our by checking the error code.
>
> I think patches 3 and 4 need to be squashed together to avoid any "git
> bisect" issues?

OK that's correct I'll fix...

Linus Walleij
