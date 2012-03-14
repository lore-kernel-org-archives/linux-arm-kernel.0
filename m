From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Mar 2012 10:02:22 +0100
Subject: [PATCH v3] serial: PL011: clear pending interrupts
In-Reply-To: <CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
 <CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
Message-ID: <CACRpkdZXrMW653W=tysY8ncqBKDun3TgPqnEzrdZPqwpW8shYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 2:47 AM, Chanho Min <chanho0207@gmail.com> wrote:
>
> I've tested this patch, and have confirmed that the issue is resolved
> on our CA9 platform.
> In addition, May I ask to change the tag as follows.
>
> Reported-by: Chanho Min <chanho.min@lge.com>
> Reviewed-by: Jong-Sung Kim <neidhard.kim@lge.com>

Thanks Chanho, Greg will you add the Reported/Reviewed-by
tags or do you want me to send a v4 of this?

Yours,
Linus Walleij
