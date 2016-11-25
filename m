From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2016 22:39:15 +0100
Subject: [GIT PULL] STi DT fix for v4.9-rcs round 2
In-Reply-To: <d109e729-0d50-40ac-ceeb-16d88a7a3e74@st.com>
References: <d109e729-0d50-40ac-ceeb-16d88a7a3e74@st.com>
Message-ID: <5235767.hXB0cg4jXx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 9:59:16 AM CET Patrice Chotard wrote:
> STi DT fix:
> 
> The I2C nodes are missing #address-cells and #size-cells.
> This is causing warning at device tree compilation when
> some I2C device sub-nodes are defined.
> 
> 

Pulled into fixes branch, thanks!

	Arnd
