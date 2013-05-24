From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 11:07:41 +0200
Subject: [PATCH 4/6] pinctrl: samsung: Add support for SoC-specific
 suspend/resume callbacks
In-Reply-To: <1368807872-2601-5-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-5-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdY-d3YYLJoWydakbT7P4wnBAK2XL7X0Fs0EcNSFakpUDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 6:24 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> SoC-specific driver might require additional save and restore of
> registers. This patch adds pair of SoC-specific callbacks per pinctrl
> device to account for this.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Patch applied for fixes.

Hm this is quite a lot of code for "fixes", can you confirm that
the system is really unusable without all these patches?

Yours,
Linus Walleij
