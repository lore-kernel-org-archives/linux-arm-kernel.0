From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 29 Jan 2016 17:48:54 +0800
Subject: [PATCH v3] i2c: mt8173: add 4GB mode support in i2c driver.
In-Reply-To: <1454031331-9107-1-git-send-email-liguo.zhang@mediatek.com>
References: <1454031331-9107-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <CAGS+omB40onjA35r=8GZ74vKCWSTH8=8ui=Xj4M0qsmA14uDDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 9:35 AM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
