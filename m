From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 5 Jul 2014 01:01:30 +0200
Subject: [PATCH v2 1/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <1402398708-10722-1-git-send-email-thierry.reding@gmail.com>
References: <1402398708-10722-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <CACRpkdaLG+f41ot0H7sRm0zq+5=HROBKpKeXJC2+JYkq6a4Yog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 1:11 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> This patch adds the device tree binding documentation for the XUSB pad
> controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
> capabilities.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - move header file to this patch and refer to it in the binding
> - update example to match the latest binding

Stephen/Laxman: any comments on this patch?

Yours,
Linus Walleij
