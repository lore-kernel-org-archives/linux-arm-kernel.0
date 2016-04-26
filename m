From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 19:55:54 +0800
Subject: [PATCH] ARM: dts: imx6: fix dtc warnings for ipu endpoints
In-Reply-To: <1461632973-10487-1-git-send-email-stillcompiling@gmail.com>
References: <1461632973-10487-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <20160426115554.GC30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 06:09:33PM -0700, Joshua Clayton wrote:
> When compiled with "W=1", dtc complains: e.g.
> "Warning (unit_address_vs_reg):
> Node /soc/ipu at 02800000/port at 2/endpoint at 0
> has a unit name, but no reg property"
> 
> Endpoint nodes don't have a reg property, and the addresses
> in their node names are ordinals without any special meaning
> so remove them and swap them for semantic node names.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

Applied, thanks.
