From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Mar 2015 10:07:26 +0100
Subject: [PATCH v4 1/4] pinctrl: bcm: consolidate Broadcom pinctrl drivers
In-Reply-To: <1423015801-26967-2-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423015801-26967-1-git-send-email-rjui@broadcom.com>
 <1423015801-26967-2-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdaiM+mqGg43BT1Kr-CNi8+_U4KgZM4iZocv9+ovHL5hLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 3:09 AM, Ray Jui <rjui@broadcom.com> wrote:

> Consolidate Broadcom pinctrl drivers into drivers/pinctrl/bcm/*
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

This patch doesn't apply so it needs to be rebased on v4.0-rc1 and resent.

And also when just moving files, always do this:

git format-patch -M ...

So that file movement is detected, and the patch will apply nicely even
if the contents of the file(s) have changed.

Can you also combine this series with the v9 GPIO etc series and
send out ONE big patch set that I can look at because right now I'm
getting really confused ...

I'll look over the rest and see if there is some remaining technical
comments (hopefully mainly patch mechanics remains).

Yours,
Linus Walleij
