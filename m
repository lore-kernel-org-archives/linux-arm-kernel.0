From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Wed, 29 Jun 2011 09:54:36 -0700
Subject: [PATCH 1/6] microblaze: move pci flag functions into asm-generic
In-Reply-To: <1309366019-24379-2-git-send-email-robherring2@gmail.com>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<1309366019-24379-2-git-send-email-robherring2@gmail.com>
Message-ID: <20110629095436.154cff94@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jun 2011 11:46:54 -0500
Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move pci_set_flags, pci_add_flags, and pci_has_flag into
> asm-generic/pci-bridge.h so other archs can use them.

Looks like something Ram may be able to re-use when adding resource
alloc behavior flags for the new bridge realloc code.

-- 
Jesse Barnes, Intel Open Source Technology Center
