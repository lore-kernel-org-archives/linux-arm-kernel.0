From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 22:30:51 +0000
Subject: [PATCH 03/15] ARM: provide runtime hook for ioremap
In-Reply-To: <1329169408-17253-4-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120213223051.GE25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:43:16PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> We have compile time over-ride of ioremap, but an run-time override is
> needed for multi-platform builds.

Are you sure we need this after Nicolas' updates to ioremap() ?
