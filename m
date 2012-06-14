From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:33:39 +0530
Subject: [PATCH 08/17] i2c: omap: switch over to do {} while loop
In-Reply-To: <1339669250-9183-9-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-9-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gw-rX9Xq7PPU9sGB=EFd4f3xfsPPDdODRyU5Jwg20v4GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> this will make sure that we execute at least once.
> No functional changes otherwise.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Executing at least once instead of never is
still a functional change :-)

Regards
Santosh
