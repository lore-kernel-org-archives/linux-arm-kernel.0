From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 1 Sep 2016 14:43:58 +0200
Subject: [PATCH v9 1/4] power: act8945a_charger: Add capacity level
 property
In-Reply-To: <1472722201-31872-2-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160901124358.64hsgqcpexnd7hmu@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 01, 2016 at 05:29:58PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
> 
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/29515981/attachment-0001.sig>
