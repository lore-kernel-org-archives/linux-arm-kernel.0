From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 14:08:43 -0800
Subject: [PATCH v2] arm/tegra: fuse: add functions to access chip revision
In-Reply-To: <1325742641-384-1-git-send-email-olof@lixom.net>
References: <1324599468-12845-5-git-send-email-olof@lixom.net>
 <1325742641-384-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F1814@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, January 04, 2012 10:51 PM:
> Add function to get chip revision, and print it out at boot time.
> 
> Restructure the fuse access to just use cached variables instead
> of always reading the fuses, and export those variables directly
> instead of using accessor functions.
> 
> Add a SKU ID table of currently known values.
> 
> Based on code originally by Colin Cross <ccross@android.com>.
> 
> Changes since v1:
> 
> * Add A01 minor rev support
> * Don't decode for A03p on anything but T2x
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
