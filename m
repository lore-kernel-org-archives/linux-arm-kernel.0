From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Mar 2016 18:04:26 +0700
Subject: [PATCH 2/3] pinctrl: ns2: add pinmux driver support for Broadcom
 NS2 SoC
In-Reply-To: <1457005303-26829-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1457005303-26829-1-git-send-email-yendapally.reddy@broadcom.com>
 <1457005303-26829-3-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <CACRpkdaKn4puDsZBPSbfkmHW4KHqBW8q1T2vpyNk_0Yb7C0AXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 6:41 PM, Yendapally Reddy Dhananjaya Reddy
<yendapally.reddy@broadcom.com> wrote:

> This adds the initial support of the Broadcom NS2 pinmux driver
>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Now yet another Broadcom driver!

Can I get the help of the maintainers of the other
Broadcom drivers to say:

- If this looks sane

- If this hardware looks suspiciously similar to one of the
  other drivers and should rather me a subdriver of one of
  the existing ones

?

Yours,
Linus Walleij
