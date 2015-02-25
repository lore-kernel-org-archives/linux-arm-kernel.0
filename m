From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 25 Feb 2015 13:29:24 +0100
Subject: [PATCH 3/7] drivers: Introduce new eFuse subsystem stub
In-Reply-To: <1424864719-3390-4-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1424864719-3390-4-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <54EDC024.2040804@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[adding devicetree list]

Am 25.02.2015 um 12:45 schrieb Ezequiel Garcia:
> This commit introduces a new eFuse subsystem stub to hold all the eFuse-like
> device drivers. This will be used to host the currently supported Tegra
> eFuse driver, and will allow to add support for other platforms as well.

as i mentioned in the old discussion it would be nice to keep drivers
and devicetree binding documentation consistent.

So how about renaming?

Documentation/devicetree/bindings/fuse/ ->
Documentation/devicetree/bindings/efuse/

Best regards
Stefan
