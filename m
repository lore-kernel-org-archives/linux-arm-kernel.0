From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 09:21:24 +0200
Subject: [PATCH 0/6] pinctrl: sirf: a bundle of fix, cleanup and upgrade
In-Reply-To: <1348739594-21034-1-git-send-email-Barry.Song@csr.com>
References: <1348739594-21034-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZGag7wRw1oG1NkYABbO+u-i7nOY9FmZRGxBvo1R8ybdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:53 AM, Barry Song <Barry.Song@csr.com> wrote:

> These patches fix some issues in SiRF pinctrl driver and also make it
> support the new SiRFmarco SMP SoCs.
>
> Tested by DM9000 using one GPIO as IO address/data switch and another
> GPIO as external IRQ source on SiRFmarco board.

This is pretty late before the merge window but since most of them would
be -rc fixes anyway I'll probably apply them...

Linus Walleij
