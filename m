From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 10:00:31 +0100
Subject: [PATCH 35/35 linux-next] pinctrl: constify of_device_id array
In-Reply-To: <1426535949-26107-4-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-4-git-send-email-fabf@skynet.be>
Message-ID: <CACRpkdZbvHxtupVsXJwK8-XZ-dOScgpWFJWPExQ5U44FRXZymw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 8:59 PM, Fabian Frederick <fabf@skynet.be> wrote:

> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Patch applied with the ACKs. Had to do some fixup on some
MTK controllers, no big deal.

Yours,
Linus Walleij
