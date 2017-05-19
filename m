From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 19 May 2017 11:29:52 -0700
Subject: [PATCH v3 1/3] ARM: BCM: Enable thermal support for NSP SoCs
In-Reply-To: <1493410291-16679-2-git-send-email-jon.mason@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <f653eff0-3e5b-5e14-6c27-53184ce48ea4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2017 01:11 PM, Jon Mason wrote:
> Change the Northstar Plus Kconfig to select THERMAL and THERMAL_OF,
> which allows the ns-thermal driver to be selected via menuconfig.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Applied, thanks Jon
-- 
Florian
