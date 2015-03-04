From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:43:39 +0100
Subject: [PATCH 0/2] ARM: multi_v7_defconfig,
 sunxi_defconfig: increase maximum number of CPUs
In-Reply-To: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
References: <1423626748-1277-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <2308137.QLJGd5NpZl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 February 2015 19:52:26 Tyler Baker wrote:
> I have recently been reviewing the kernel warnings generated from the kernelci.org boot farm, and have discovered that the HiP04 and a80-optimus boards have more CPUs then the maximum allowed in a few of the ARM defconfigs. This series fixes those warnings by increasing the maximum number of CPUs. I went ahead and boot tested these patches on various boards [1] to insure there are no regressions introduced when increasing the number of CPUs. 
> 
> Any comments would be appreciated. Perhaps we may want to increase these limits further?

I've applied your version. Increasing the limit more would mainly cause memory
to be wasted, so I don't think that's a good idea until we need to support
other hardware.

	Arnd
