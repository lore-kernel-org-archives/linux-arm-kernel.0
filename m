From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jun 2012 23:26:46 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FE882A5.3080504@nvidia.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
Message-ID: <20120625222646.GB30406@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 08:54:21PM +0530, Laxman Dewangan wrote:

> I had detailed discussion with Mark on  this support and as per him
> (based on my understanding), the input to different regulator is
> from the pin of the chips and so the name should be the
> <pin-name>-supply which should be part of chip-dt binding, not to
> the particular rail.

More specifically, all the supplies for a device (including those that
happen to be inputs for regulators) should be specified in exactly the
same fashion.  This makes the binding more regular and means that users
can just go through the schematic adding the mappings without worrying
about what what the supply happens to be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/342fb195/attachment.sig>
