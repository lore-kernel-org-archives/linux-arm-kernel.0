From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:47:25 +0100
Subject: [PATCH 5/9] drm: replace "drm_connector_unreference" with
 "drm_connector_put"
In-Reply-To: <20181115221634.22715-6-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-6-greenfoo@gluegarage.com>
Message-ID: <CACRpkdbUK-Xx4XfLPAzJdH_R_JADFDxKkvQLiYeZyd6sJ02Pzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied.

Yours,
Linus Walleij
