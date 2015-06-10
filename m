From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 13:56:55 +0200
Subject: [PATCH 20/34] pinctrl: mvebu: armada-xp: fix binding
 documentation of ge1 pins
In-Reply-To: <1433868446-11028-21-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-21-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdYv4G5i2Ut2f+YG=7NpO3=VZv7N6KfyykU5NS_CKS9XTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> There was an off-by-one in the documentation of the ge1(txd[0-3])
> pins, which is fixed by this commit. Since the driver was correct, and
> the subnames are anyway not used in the DT binding itself, there is no
> need to push this documentation fix for stable.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
