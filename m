From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 11:12:00 +0200
Subject: [PATCH v3 6/6] pinctrl: exynos: Handle suspend/resume of GPIO
 EINT registers
In-Reply-To: <3059629.yu4Ei1BXhd@amdc1227>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <4536937.hnhaYZLnaG@amdc1227>
 <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
 <3059629.yu4Ei1BXhd@amdc1227>
Message-ID: <CACRpkdbN4Nxg2VSr0bf+h4Y2U=CmX9mijdZz+=tom9V0-i-69g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 4:03 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> Some GPIO EINT control registers needs to be preserved across
> suspend/resume cycle. This patch extends the driver to take care of
> this.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>
> Changes since v2:
>  - Fixed error path
> Changes since v1:
>  - Added optional debugging messages
>  - Added proper error path in initialization

v2 version applied for fixes.

Again confirm you must really have all this. It is not looking
good with diffstats like this for fixing regressions.

Yours,
Linus Walleij
