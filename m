From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 6 Sep 2013 12:01:41 -0500
Subject: [PATCHv2 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <522A0977.5060703@codeaurora.org>
References: <1378425890-4225-1-git-send-email-rvaswani@codeaurora.org>
 <20A8A05D-2F56-4127-A494-470833B2DC42@codeaurora.org>
 <522A0977.5060703@codeaurora.org>
Message-ID: <8E887DF7-5941-480E-8D05-80EFCC960B91@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 6, 2013, at 11:57 AM, Rohit Vaswani wrote:

> On 9/6/2013 7:22 AM, Kumar Gala wrote:
>> On Sep 5, 2013, at 7:04 PM, Rohit Vaswani wrote:
>> 
>>> This patch adds basic board support for MSM8974 Dragonboard
>>> which belongs to the Snapdragon 800 family.
>>> For now, just support a basic machine with device tree.
>>> 
>>> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
>>> ---
>>> arch/arm/boot/dts/Makefile        |  3 ++-
>>> arch/arm/boot/dts/msm8974-db.dts  |  7 +++++++
>>> arch/arm/boot/dts/msm8974.dtsi    | 30 ++++++++++++++++++++++++++++++
>>> arch/arm/mach-msm/Kconfig         | 20 ++++++++++++++++++--
>>> arch/arm/mach-msm/Makefile        |  1 +
>>> arch/arm/mach-msm/board-dt-8974.c | 23 +++++++++++++++++++++++
>>> 6 files changed, 81 insertions(+), 3 deletions(-)
>>> create mode 100644 arch/arm/boot/dts/msm8974-db.dts
>>> create mode 100644 arch/arm/boot/dts/msm8974.dtsi
>>> create mode 100644 arch/arm/mach-msm/board-dt-8974.c
>> As I mentioned before, its the APQ8074 Dragonboard, not MSM8974
> 
> We are not going with the internal (mangled) naming schemes for this as the configs etc. are all aligned to MSM8974 and we will only have this 1 platform as our upstream platform.

I'm not sure I understand your point.

We call it the DB8074 and not DB8974:

http://mydragonboard.org/db8074/

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
