From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 6 Jul 2018 15:01:52 +0300
Subject: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
In-Reply-To: <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
 <d99935be-797d-4676-c186-a045a590f01b@gmail.com> <11534185.70fb5jbPr6@dimapc>
 <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
Message-ID: <7c38961f-4ad6-f4b8-7ef1-b43a07353832@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kexec works for me on T30 with the following kernel config options on top of the
tegra_defconfig:

CONFIG_SMP=n
CONFIG_CPU_IDLE=n
CONFIG_TEGRA_IOMMU_SMMU=n

CPU stopping isn't working correctly with the trusted foundations and it's not
obvious what is wrong. I hope we'll fix it at some point.
