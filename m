From: tj@kernel.org (Tejun Heo)
Date: Wed, 21 Jan 2015 07:31:34 -0500
Subject: next-20150120 broken on Tegra by "ata: libahci: Allow using
 multiple regulators"
In-Reply-To: <20150121105001.GA9921@ulmo.nvidia.com>
References: <alpine.DEB.2.02.1501210003010.5450@utopia.booyaka.com>
 <20150121105001.GA9921@ulmo.nvidia.com>
Message-ID: <20150121123134.GD8684@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 11:50:03AM +0100, Thierry Reding wrote:
> Tejun, preferably the attached patch should be squashed into commit
> c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators") to avoid
> breaking bisectability. If you don't want to rewrite history, let me
> know and I can turn it into a proper patch.

Yes, please make it a proper patch.

Thanks a lot!

-- 
tejun
