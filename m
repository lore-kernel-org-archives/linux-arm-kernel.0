From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:49:38 +0100
Subject: [PATCH 6/9] drm: remove deprecated "drm_connector_[un]reference"
 functions
In-Reply-To: <20181115221634.22715-7-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-7-greenfoo@gluegarage.com>
Message-ID: <CACRpkdZwHTJCh4cps6+9=5CPyfeZyTQ9kbOnVGakEGAxwOdW2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> There are no more places where this (deprecated) function is being
> used from, thus it can now be removed.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied collecting Paul's review tag.

Yours,
Linus Walleij
