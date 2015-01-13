From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 15:33:44 +0100
Subject: [PATCH 0/4] pinctrl: qcom: Add multiple copy support
In-Reply-To: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
References: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
Message-ID: <CACRpkdZsDkrCJ=8dPDXQpWzeh=QWAUd1BBHGgsdpnNh77OOAAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 9:59 PM, Andy Gross <agross@codeaurora.org> wrote:

> These patches add multiple copy support for functions which require additional
> mux configurations on specific Qualcomm processor pincontrol blocks.  Functions
> which may have multiple copies are slimbus, mi2s, pdm, pcie, and GSBI.

Bj?rn, can you look at this?

Yours,
Linus Walleij
