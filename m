From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:52:19 -0700
Subject: [PATCH] ARM: tegra: enable ULPI phy on Colibri T20
In-Reply-To: <1374603105-21226-1-git-send-email-swarren@wwwdotorg.org>
References: <1374603105-21226-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130804205219.GA19070@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 11:11:45AM -0700, Stephen Warren wrote:
> From: Lucas Stach <dev@lynxeye.de>
> 
> This was missed when splitting out the phy from the controller node in
> commit 9dffe3be3f32 (ARM: tegra: modify ULPI reset GPIO properties).
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd, this is a fix for 3.11. Thanks!

Applied.


-Olof
