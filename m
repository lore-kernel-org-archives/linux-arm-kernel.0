From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 14:59:01 +0200
Subject: [PATCH] pinctrl: dove: add PMU functions to pinctrl
In-Reply-To: <1367883368-27889-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367883368-27889-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZVBiTJCPaSmPGTPs+aaRf2VQt+Zz=odL47ysg4a1c0RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 7, 2013 at 1:36 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> Dove power management unit can mux some special functions to mpp0-15.
> This patch adds support to set/get the current PMU function mapped
> to the corresponding mpp pins. The device tree documentation is also
> updated accordingly.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Patch applied with Jason's ACK.

Thanks!
LInus Walleij
