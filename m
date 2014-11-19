From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Nov 2014 10:17:32 +0800
Subject: [PATCH 1/2] ARM: imx: Remove unneeded .map_io initialization
In-Reply-To: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
References: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141119021730.GA27759@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:53:57PM +0100, Geert Uytterhoeven wrote:
> If machine_desc.map_io is not set, devicemaps_init() in the common ARM
> code will call debug_ll_io_init().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.
