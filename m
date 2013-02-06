From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Feb 2013 09:36:42 +0100
Subject: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20130206093642.32c91724@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Wed,  9 Jan 2013 21:43:06 +0100, Thierry Reding wrote:
> When using deferred driver probing, PCI host controller drivers may
> actually require this function after the init stage.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
