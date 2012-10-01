From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Oct 2012 08:58:32 +0200
Subject: [RFC PATCH 00/16] pinctrl: samsung: Usability and extensibiltiy
 improvements
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdaDxy5py_+XW=YE+hur69QuYaZXfq-oAo-mGH7o6docPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 4:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> This RFC series is a work on improving usability and extensibiltiy of the
> pinctrl-samsung driver. It consists of three main parts:
>  - moving SoC-specific data to device tree
>  - converting the driver to use one GPIO chip and one IRQ domain per pin bank
>  - introducing generic wake-up interrupt capability description

Overall this looks good to me.

Yours,
Linus Walleij
