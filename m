From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 21:38:31 +0800
Subject: [PATCH 1/2] ARM: dts: vf-colibri: remove container node of
 regulators
In-Reply-To: <1455588854-6996-1-git-send-email-stefan@agner.ch>
References: <1455588854-6996-1-git-send-email-stefan@agner.ch>
Message-ID: <20160218133831.GX6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:14:13PM -0800, Stefan Agner wrote:
> Drop the fake simple-bus container 'regulators' and put the
> regulators directly under the root node. This also makes the
> artificial 'reg' properties superfluous.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.
