From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Feb 2014 09:51:38 +0100
Subject: [PATCH] pinctrl: imx: Fix pin name in debug message.
In-Reply-To: <20140220143012.23570.63407.stgit@localhost>
References: <20140220143012.23570.63407.stgit@localhost>
Message-ID: <CACRpkdZww=A1+AOH=rHidUqfW55wfH=ZVJbg618T=8t_kr6oJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 3:30 PM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> The wrong index counter was being used, causing the debug message
> to show an incorrect pin name.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

Patch applied, unless the i.MX maintainers have objections.

Yours,
Linus Walleij
