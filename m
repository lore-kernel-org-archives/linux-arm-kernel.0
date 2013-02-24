From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 24 Feb 2013 02:01:45 +0100
Subject: [PATCH] i2c: s3c2410: check for NULL pinctrl handle
In-Reply-To: <31669750.ZZOiY1AEPv@flatron>
References: <201302231855.47560.heiko@sntech.de> <5027662.bpQdq7jhyn@flatron>
 <CACRpkdaFv=V8M_Ztb5-hrYm6YnXiG6fg6Z13y3NVFdszBk=7ZQ@mail.gmail.com>
 <31669750.ZZOiY1AEPv@flatron>
Message-ID: <CACRpkdYBjZgEo6qEyBOcYuPzpQUAZ9x-kvFabz0y0pEQs35sKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 24, 2013 at 1:58 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> [Me]
>> Surely you know this when setting up the pdata from your machine?
>
> Cases 2) and 3) are both DT-enabled cases, where there is no pdata coming
> from board-specific code.
(...)
> Note that we are talking here about a temporary solution. The legacy DT-
> based pin configuration will go away after all the DT-enabled platforms
> using this driver get migrated to pin control and so will the need to
> check if pin control is available.

So use AUXDATA, and you get a pdata for that driver?

Yours,
Linus Walleij
