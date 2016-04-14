From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 14 Apr 2016 14:07:52 +0100
Subject: [PATCH v2] ARM: arm64: dts: Add expansion bus to VExpress and Juno
In-Reply-To: <1460627546-24230-1-git-send-email-brian.starkey@arm.com>
References: <1460627546-24230-1-git-send-email-brian.starkey@arm.com>
Message-ID: <570F9628.70106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/04/16 10:52, Brian Starkey wrote:
> The VExpress and Juno development platforms have an external expansion
> bus which can be used for additional hardware (e.g. LogicTile Express
> daughterboards).
> Add this bus to all VExpress CoreTile and Juno device-trees.
>

Sorry for missing it earlier, ARM-SoC guys like to keep arm{32,64}
changes separate. So please move Juno DT changes to separate patch.

-- 
Regards,
Sudeep
