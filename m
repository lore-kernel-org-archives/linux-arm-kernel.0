From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2016 22:46:17 -0300
Subject: [PATCH v3 1/3] PCI: imx6: Use enum instead of bool for variant
 indicator
In-Reply-To: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5ArMbdSDrh+V4EpUS+HOdqJa94XLm+U0vQiwfrD7gVyuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Use enumerated type instead of a boolean flag to specify the variant of
> the PCIe IP block (6Q, 6SX, etc). This patch has zero functional impact,
> however it makes the code easier to extend for the case of more than 2
> possible variants of an IP block (of which there are).
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
