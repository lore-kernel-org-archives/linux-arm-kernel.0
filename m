From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:34:19 +0100
Subject: [PATCH v2 1/7] dt-binding: Add ngpios property to GPIO controller
 node
In-Reply-To: <1447905139-16002-2-git-send-email-pramodku@broadcom.com>
References: <1447905139-16002-1-git-send-email-pramodku@broadcom.com>
 <1447905139-16002-2-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdYxaccZDPkmxXe2EwqoJ_U3DU6AzmsizECrd=5=1J5ipw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 4:52 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Add ngpios property to the gpio controller's DT node so that controller
> driver extracts total number of in-use gpio lines from DT and removes
> dependency on driver.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
