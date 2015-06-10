From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:55:33 +0200
Subject: [PATCH 05/34] pinctrl: mvebu: armada-xp: remove non-existing VDD
 cpu_pd functions
In-Reply-To: <1433868446-11028-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaimdaFqcLjcQx5t3MHxFsH4TgtCq0aJV6q5Ovz_4285g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:46 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The latest version of the Armada XP datasheet no longer documents the
> VDD cpu_pd functions, which might indicate they are not working and/or
> not supported. This commit ensures the pinctrl driver matches the
> datasheet.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.7+
> Fixes: 463e270f766a ("pinctrl: mvebu: add pinctrl driver for Armada XP")

Patch applied.

Yours,
Linus Walleij
