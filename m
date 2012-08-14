From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:40:09 +0200
Subject: [PATCH 02/22] ARM: ux500: Ensure probing of Audio devices when
 Device Tree is enabled
In-Reply-To: <1344527268-5964-3-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ9XBTx_MQ9eDN_wOpeAXVt2REa7yr4ngd-0MDhsvZN3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Previous attempts to add platform probing of the Audio related devices
> only call from non-DT initialisation functions. This patch extends that
> functionality to the Device Tree related ones too.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to ux500 fixes. Will send upstream for the -rc:s.

Yours,
Linus Walleij
