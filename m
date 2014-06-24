From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Jun 2014 08:26:39 -0400
Subject: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140624122639.GL10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 07:32:58PM -0500, suravee.suthikulpanit at amd.com wrote:
> This patch set introduces support for MSI(-X) in GICv2m specification,
> which is implemented in some variation of GIC400.
> 
> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
> (https://lkml.org/lkml/2014/3/14/320).

Is this a build, boot, or runtime dependency?

thx,

Jason.
