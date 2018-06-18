From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Jun 2018 09:48:18 -0700
Subject: [PATCH 0/5] Fix Cygnus, NS2, Stingray interrupt type
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <ac955f7d-6770-63a1-db85-024b0ee0b8af@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> This patch series fixes incorrect interrupt types for I2C and PCIe in DT
> for Broadcom Cygnus, NS2, and Stingray SoCs
> 
> This patch series is based off v4.17 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: cygnus-ns2-dt-irq-type-fix-v1

Series applied to:

- 1&2: devicetree/fixes
- 3-5: devicetree-arm64/fixes

Thanks Ray.
-- 
Florian
