From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Mar 2016 15:25:55 +0700
Subject: [PATCH 5/5] ARM: bcm2835: Move most RPi default pin groups to
 their devices.
In-Reply-To: <1456510756-15337-6-git-send-email-eric@anholt.net>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-6-git-send-email-eric@anholt.net>
Message-ID: <CACRpkdYCe_iOLEae1NP=xFLRvXXsMEUguLxj9n8Udf=ZuOFmFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 1:19 AM, Eric Anholt <eric@anholt.net> wrote:

> This way we can get the duplicated pin group definitions out of each
> RPi board file, and just leave the i2s variations in them.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Aha I speak too soon I see. This set of patches look fine to
me but you need to address Stephens comments and obtain his
ACK.

Yours,
Linus Walleij
