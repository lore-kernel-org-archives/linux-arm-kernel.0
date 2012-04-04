From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 10:52:01 -0700
Subject: [PATCH 02/11] ARM: tegra: Remove VBUS_GPIO handling from board
 files
In-Reply-To: <1333148404-17691-3-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404175201.GB29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:59:55PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Instead of having board files manually request and initialize USB VBUS
> GPIOs, fill in the USB driver's platform data and have it do it.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>                                                                    


-Olof
