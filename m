From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 23:21:28 +0200
Subject: [PATCH 18/19] gpio: Provide the tc3589x GPIO expander driver with
 an IRQ domain
In-Reply-To: <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZKrvU3s+f+nVXOPkcFUWnq9KaFtPNCcs+fP8POGQ1Lvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In preparation for Device Tree enablement all IRQ controllers
> should control their own IRQ domain. This patch provides just
> that for the tc3589x GPIO expander.
>
> CC: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I've applied this to my GPIO tree, I couldn't resist. It's just such
a nice patch nicing up the code and I wanted it tested so it can
go into the next merge window.

If you need to send patches to the ARM SoC tree, just state
the devel branch from my tree as dependency.

Yours,
Linus Walleij
