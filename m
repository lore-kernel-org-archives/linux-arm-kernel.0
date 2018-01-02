From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 09:49:38 +0100
Subject: [PATCH 1/2] pinctrl: single: Delete an error message for a failed
 memory allocation in pcs_probe()
In-Reply-To: <bc8e7af9-6dcb-6f08-388a-31fc1b88cd00@users.sourceforge.net>
References: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
 <bc8e7af9-6dcb-6f08-388a-31fc1b88cd00@users.sourceforge.net>
Message-ID: <CACRpkdYEnJv2SsR_+Jt=Rp364VgRukjDJ=gBC55X5zOSvu92xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 2:06 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 25 Dec 2017 11:27:55 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
