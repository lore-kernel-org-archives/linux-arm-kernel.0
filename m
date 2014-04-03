From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 17:55:14 +0200
Subject: [PATCH] ARM: ux500: Staticise ux500_soc_attr
In-Reply-To: <1396425668-2571-1-git-send-email-treding@nvidia.com>
References: <1396425668-2571-1-git-send-email-treding@nvidia.com>
Message-ID: <CACRpkdbxNN_dFVHTxGWOkiQcEE=YTRe=w8T8WtiGw+JbCLaAOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 10:01 AM, Thierry Reding <treding@nvidia.com> wrote:

> This variable is not used outside of the file that it's declared in, so
> reduce the scope to the local file.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied to the ux500 tree.

Yours,
Linus Walleij
