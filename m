From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Jun 2014 09:11:49 +0200
Subject: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
In-Reply-To: <53915F3B.6050806@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <5390A8F9.2090408@wwwdotorg.org> <53915F3B.6050806@nvidia.com>
Message-ID: <20140606071148.GC31915@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 09:27:07AM +0300, Mikko Perttunen wrote:
> The only compile-time dependencies here should be that:
> - patch 8 of 9 which contains the actual driver depends on patch 6 of 9
> (though only when building as a module) and the efuse series
> - patch 2 of 9 refers to the DT node called "padctl", so it requires the
> xusb series. (in the submitted xusb series, the node isn't actually named,
> though. I will fix this in v2)

My intention was to add the label in the patch which first adds a
reference to the device. In my tree that was the PCIe driver. Given that
it's not clear yet in what order these will be merged, I'm thinking I
should simply add that fragment in the patch that adds the node since we
know that it will eventually be used.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/d7574596/attachment-0001.sig>
