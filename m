From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 09 Apr 2010 12:50:15 +0100
Subject: [alsa-devel] [PATCH] WM8750: Convert to new API
In-Reply-To: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
References: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1270813815.4618.0.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-04-08 at 20:48 +0200, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Also, this patch fixes the Jive and Spitz machine.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
