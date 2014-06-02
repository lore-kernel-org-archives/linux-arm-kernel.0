From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jun 2014 15:26:13 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <20140602123851.GB2654@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana> <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana> <20140530192516.GA4319@lee--X1>
 <20140531134805.GA3287@katana>
 <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
 <20140602123851.GB2654@katana>
Message-ID: <CACRpkdbnzy3rSXQ8AFAYmtM93MGKmRj2F566LMvKDhtSw2MLxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 2:38 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Though, I wouldn't mind if compatible entries could be passed to the
> 'new_device' file, in addition to i2c_device_ids. Yet, this needs some
> extra handling I haven't found the time for, yet.

Hm that's a way forward then I guess... but passing a compatible
string to that same file is a bit arbitrarily ambigous. So we'd rather
add a new instatiation file named new_device_of_compatible or so?

Yours,
Linus Walleij
