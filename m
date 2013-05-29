From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 May 2013 11:46:47 -0700
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <000001ce5c4f$839f4cb0$8adde610$@samsung.com>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 <87sj1qzaov.fsf@linaro.org> <5191AA89.6010901@linaro.org>
 <20130528231740.GA28879@quad.lixom.net>
 <51A57D39.8030506@linaro.org>
 <CAOesGMh50Dzr_jczHZC5_txfW=6a+7EgFKvgZgj9MhUcVUTJ1Q@mail.gmail.com>
 <51A5C16D.20408@linaro.org>
 <000001ce5c4f$839f4cb0$8adde610$@samsung.com>
Message-ID: <CAOesGMiYs6GfaWGWYB8cw_cJ6_RmmZTb4oPfXo1PYJT8-jdHzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 2:33 AM, Jingoo Han <jg1.han@samsung.com> wrote:

> However, Olof Johansson mentioned, 'drivers/platform/arm/board_arndale.c'
> would be a good alternative.


Whoa. I didn't quite realize what I proposed, or rather, how what I
proposed could be perceived. I take it back. :)

We must _not_ introduce something that will be abused as a new home
for board file junk. If we do introduce a platform glue directory it
would need to be very limited in scope. Compare to what's in
drivers/platform/x86 today.


-Olof
