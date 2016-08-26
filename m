From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Aug 2016 08:15:09 -0700
Subject: [PATCH] ARM: dts: dra7xx: Increase spi-max-frequency to 76.8MHz
 for QSPI
In-Reply-To: <20160801130655.15004-1-vigneshr@ti.com>
References: <20160801130655.15004-1-vigneshr@ti.com>
Message-ID: <20160826151508.ac5uy7557lovbd7r@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [160801 06:07]:
> According to AM572x DM SPRS953A, QSPI maximum bus speed can be 76.8MHz.
> Therefore, increase the spi-max-frequency value of QSPI node to 76.8MHz
> for DRA74 and DRA72 evm. This improves flash raw read speed by ~2MB/s.

Applying into omap-for-v4.9/dt thanks.

Tony
