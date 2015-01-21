From: treding@nvidia.com (Thierry Reding)
Date: Wed, 21 Jan 2015 16:55:21 +0100
Subject: next-20150120 broken on Tegra by "ata: libahci: Allow using
 multiple regulators"
In-Reply-To: <20150121123134.GD8684@htj.dyndns.org>
References: <alpine.DEB.2.02.1501210003010.5450@utopia.booyaka.com>
 <20150121105001.GA9921@ulmo.nvidia.com>
 <20150121123134.GD8684@htj.dyndns.org>
Message-ID: <20150121155519.GA25166@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 07:31:34AM -0500, Tejun Heo wrote:
> On Wed, Jan 21, 2015 at 11:50:03AM +0100, Thierry Reding wrote:
> > Tejun, preferably the attached patch should be squashed into commit
> > c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators") to avoid
> > breaking bisectability. If you don't want to rewrite history, let me
> > know and I can turn it into a proper patch.
> 
> Yes, please make it a proper patch.
> 
> Thanks a lot!

Attaching the patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ata-libahci-Fix-devres-cleanup-on-failure.patch
Type: text/x-diff
Size: 1961 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/416f7897/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/416f7897/attachment.sig>
