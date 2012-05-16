From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 09:55:51 +0200
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <4FB35BC7.8060709@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org> <201205031257.52100.arnd@arndb.de>
 <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
 <4FB35343.4090407@linaro.org>
 <CACRpkdZziyAtUvDPhzvdhaUSFYQ5QjTEDJKWTQOaB4D+7A+qrQ@mail.gmail.com>
 <4FB35BC7.8060709@linaro.org>
Message-ID: <CACRpkdZSLF6MG66V5WSNQwXbTd8Lp-F002GrbctZ4vQDTGbWrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 9:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 16/05/12 08:38, Linus Walleij wrote:
>> On Wed, May 16, 2012 at 9:12 AM, Lee Jones<lee.jones@linaro.org> ?wrote:
>>> On 03/05/12 18:14, Linus Walleij wrote:
>>
>> Two exactly identical arrays just on different line numbers, yeah...
>
> Eh? Did you quote the wrong line?

Maybe, anyway that was the problem, was it not?
I'm ever more confused with this, maybe git is confused
too :-)

>> So how to we fix it? With an incremental patch on top?
>
> I can provide you with a patch really quickly if that's the way you want to
> go.

You can send it directly to ARM SoC maintainers I think,
since that is where the problem sits right now. I'll just ACK it.

Yours,
Linus Walleij
