From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Sep 2017 14:50:04 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdb563nCp9iptfzZOUPX6B0-qU+iWzurn-JL4PQCPHqStw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 7, 2017 at 5:33 PM, Timur Tabi <timur@codeaurora.org> wrote:

> First patch allows for for pinctrl-msm to understand GPIO groups with
> no pins.  Such pins are "hidden" and can't be exported or accessed.
>
> Second patch updates the QDF2xxx driver to take advantage of all that.
>
> v5:
>  Since gpiochip_add_data no longer requests GPIOs before scanning for
>  the direction (that patch was reverted), pinctrl-msm.c now specifically
>  checks for special case.

Waiting for Bjorn's review on these.

Yours,
Linus Walleij
