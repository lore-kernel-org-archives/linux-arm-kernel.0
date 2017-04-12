From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 12 Apr 2017 09:09:49 -0700
Subject: [PATCH v5 3/3] DT nodes for Broadcom Northstar2 USB DRD Phy
In-Reply-To: <1491981125-6859-4-git-send-email-raviteja.garimella@broadcom.com>
References: <1491981125-6859-1-git-send-email-raviteja.garimella@broadcom.com>
 <1491981125-6859-4-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <e77ee510-0598-a906-11a3-edefa601f2c4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 12:12 AM, Raviteja Garimella wrote:
> This patch adds device tree nodes for USB Dual Role Device Phy for
> Broadcom's Northstar2 SoC.

The subject of this patch should be something like:

arm64: dts: NS2: Add USB DRD PHY Device Tree node

to be consistent with prior submissions done to the same file.

Depending on the fate of the patch series, I will either fix it up
myself while applying, or please include this change in a respin.
-- 
Florian
