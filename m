From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jun 2013 11:16:17 +0200
Subject: [PATCH] gpio: msm-v1: Remove errant __devinit to fix compile
In-Reply-To: <51BF43F4.9000007@codeaurora.org>
References: <1370373600-31921-1-git-send-email-sboyd@codeaurora.org>
 <CACRpkdZ5x3q9tn3J5_mQj-nJ_wO3HWgX5DTMQdMzF3mUDrAieQ@mail.gmail.com>
 <51BF43F4.9000007@codeaurora.org>
Message-ID: <CACRpkdZ=VbMUBfHt-GruTzc5_7vF508XFAW50YZb4ouG1TrjZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 7:14 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/16/13 22:54, Linus Walleij wrote:
>> On Tue, Jun 4, 2013 at 9:20 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>
>>> Commit 7bce696 (gpio: Make gpio-msm-v1 into a platform driver,
>>> 2013-03-04) was based on an older kernel where __devinit still
>>> existed. Remove the erroneous __devinit marking.
>>>
>>> Cc: David Brown <davidb@codeaurora.org>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> Patch applied.
>
> Thanks. It looks like David picked this up and sent it off to arm-soc
> last week. Cc'ing Olof for awareness of a possible duplicate.

Did that get ack by some GPIO maintainer?

This needs to go through the GPIO tree, but I
guess GIT will survive if it ends up in two trees.

Yours,
Linus Walleij
