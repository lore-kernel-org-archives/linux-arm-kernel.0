From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 09:04:11 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <20170830112424.7a3a7c36@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
Message-ID: <CACRpkdZAPJVNBwro3ddoOZVDr=qzRc_5v1+wmRNYX7r1b8q8YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 11:24 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Commit "gpiolib: request the gpio before querying its
> direction" (108d23e322a247d9f89ba2e2742520ead0944cc9) is causing a
> regression on Marvell platforms, and potentially other platforms as
> well. With this commit applied, we lose the serial console. Reverting
> this commit makes the serial console functional again.

I have reverted this patch for now.

Yours,
Linus Walleij
