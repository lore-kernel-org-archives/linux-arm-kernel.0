From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 13:20:52 +0100
Subject: [PATCH] pinctrl: mvebu: Delete an error message for a failed
 memory allocation in mvebu_pinctrl_probe()
In-Reply-To: <ba1158ce-87be-6033-72b6-b08d7babc443@users.sourceforge.net>
References: <ba1158ce-87be-6033-72b6-b08d7babc443@users.sourceforge.net>
Message-ID: <CACRpkdZ7bN-1nGLSkRTr_ehZJ1YykGN7EYEZErVkf1r3eXtdQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 10:37 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 19 Dec 2017 22:30:36 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
