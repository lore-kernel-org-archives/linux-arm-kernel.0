From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2016 22:47:10 -0300
Subject: [PATCH v3 2/3] PCI: imx6: Implement reset sequence for i.MX6+
In-Reply-To: <1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
 <1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5AiaNFashMd6XEz=zjyodm6UEAuBMsK=otQ5nHeE+voqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
> instead of a regular reset sequence since using the latter will hang the
> SoC.
>
> This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
