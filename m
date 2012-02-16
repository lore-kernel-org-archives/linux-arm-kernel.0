From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 16:17:35 -0800
Subject: [PATCH 04/15] ARM: imx: convert to common runtime ioremap hook
In-Reply-To: <1329169408-17253-5-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120216001734.GD30946@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:43:17PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Convert i.MX platforms to use the common run-time ioremap hook instead of
> the imx specific hook.
> 
> Also, move addr_in_module out of io.h.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
