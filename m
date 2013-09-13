From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 10:38:21 +0200
Subject: [PATCH 4/7] ptp: switch to use gpiolib
In-Reply-To: <20130910141912.GB5088@netboy>
References: <1378816260-8091-1-git-send-email-linus.walleij@linaro.org>
 <20130910141912.GB5088@netboy>
Message-ID: <CACRpkdZOCkLmgQHZSiqQfvLp=WzNsaE5AcY3siJ0b=bL0Xv8Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 4:19 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Sep 10, 2013 at 02:31:00PM +0200, Linus Walleij wrote:

>> Hi Richard, I'm seeking an ACK on this patch to take it throug
>> the GPIO tree as part of a clean-out of custom GPIO implementations.
>
> I don't have this hardware for testing (it is really obsolete now),
> but the change looks okay to me.
>
> Acked-by: Richard Cochran <richardcochran@gmail.com>

Thanks, I have found numerous active hobbyists using the
IXP4-based NSLU2 NAS machine for various things - mostly
non-network related as it happens, so it'll be with us for a
while I think.

Yours,
Linus Walleij
