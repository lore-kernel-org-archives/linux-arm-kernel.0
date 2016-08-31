From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:44:46 +0200
Subject: [PATCH v8 02/11] power: act8945a_charger: Achieve properties
 from its node
In-Reply-To: <1472109599-21915-3-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831144446.2quz6f3rcphqk3go@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:19:50PM +0800, Wenyou Yang wrote:
> Since the act8945a_charger is regarded as a sub-device, all properties will
> be assigned to its own device node. All properties can be achieved from its
> own node, instead of from its parent device.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/0b3a4340/attachment.sig>
