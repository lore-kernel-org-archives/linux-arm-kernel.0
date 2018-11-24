From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:38:35 +0100
Subject: [PATCH 2/9] drm: remove deprecated
 "[__]drm_gem_object_[un]reference[_locked]" functions
In-Reply-To: <20181115221634.22715-3-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-3-greenfoo@gluegarage.com>
Message-ID: <CACRpkdZu+RPr4MrsqF_t4Rd0LAu_rYR4omoLh69+02Qhg21jxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> There are no more places where these (deprecated) functions are being
> used from, thus they can now be removed.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied to drm-misc-next.

Yours,
Linus Walleij
