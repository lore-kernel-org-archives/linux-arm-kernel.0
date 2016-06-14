From: eric@anholt.net (Eric Anholt)
Date: Tue, 14 Jun 2016 10:37:10 -0700
Subject: [PATCH v2 1/9] pinctrl: walk into bcm subdir unconditionally
In-Reply-To: <CACRpkdZ+RnCo=GhsRrY0+VxLYcETrUZZGrbH-O3rwO7rRSG-ow@mail.gmail.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-2-git-send-email-kraxel@redhat.com>
 <CACRpkdZ+RnCo=GhsRrY0+VxLYcETrUZZGrbH-O3rwO7rRSG-ow@mail.gmail.com>
Message-ID: <87porjoent.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Fri, Jun 3, 2016 at 8:18 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> There is no ARCH_BCM on arm64, and we need pinctrl-bcm2835 for the rpi3.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> I see I got an identical patch from Florian Fainelli and applied it.
> Sorry for my clashes, confusion and screwups... Added Eric's
> ACK on the applied patch.

Florian's had a nice commit message, and I'm just happy to see patches
land.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160614/e6ea7959/attachment.sig>
