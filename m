From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 16:19:56 -0800
Subject: [PATCH 14/15] ARM: remove bunch of now unused mach/io.h files
In-Reply-To: <1329169408-17253-15-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-15-git-send-email-robherring2@gmail.com>
Message-ID: <20120216001956.GE30946@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:43:27PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that many platforms don't need mach/io.h, remove the usused ones.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
...
>  delete mode 100644 arch/arm/mach-mxs/include/mach/io.h
...
>  delete mode 100644 arch/arm/plat-mxc/include/mach/io.h

Acked-by: Shawn Guo <shawn.guo@linaro.org>
