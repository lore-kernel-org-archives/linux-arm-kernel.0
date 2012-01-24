From: olof@lixom.net (Olof Johansson)
Date: Tue, 24 Jan 2012 00:34:13 -0800
Subject: [PATCH 1/6] ARM: tegra: Remove use of TEGRA_GPIO_TO_IRQ
In-Reply-To: <20120104195218.GF15503@ponder.secretlab.ca>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <20120104195218.GF15503@ponder.secretlab.ca>
Message-ID: <20120124083413.GA14484@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 04, 2012 at 12:52:18PM -0700, Grant Likely wrote:
> On Wed, Jan 04, 2012 at 11:39:33AM -0700, Stephen Warren wrote:
> > Replace compile-time usage of TEGRA_GPIO_TO_IRQ with run-time calls to
> > gpio_to_irq(). This will allow the base IRQ number for the Tegra GPIO
> > driver to be dynamically allocated in a later patch.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> For the whole series:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>


Thanks, applied 1-6 to tegra for-3.4 (version 2 of patch 6).


-Olof
