From: ilias.apalodimas@linaro.org (Ilias Apalodimas)
Date: Thu, 24 May 2018 14:50:39 +0300
Subject: [PATCH v2 03/40] iommu/sva: Manage process address spaces
In-Reply-To: <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
 <20180522094334.71f0e36b@jacob-builder>
 <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
Message-ID: <20180524115039.GA10260@apalos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Interesting, I hadn't thought about this use-case before. At first I
> thought you were talking about mdev devices assigned to VMs, but I think
> you're referring to mdevs assigned to userspace drivers instead? Out of
> curiosity, is it only theoretical or does someone actually need this?

There has been some non upstreamed efforts to have mdev and produce userspace
drivers. Huawei is using it on what they call "wrapdrive" for crypto devices and
we did a proof of concept for ethernet interfaces. At the time we choose not to
involve the IOMMU for the reason you mentioned, but having it there would be
good.

Thanks
Ilias
