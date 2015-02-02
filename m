From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 02 Feb 2015 09:58:57 +0100
Subject: [PATCH v3 00/20] power_supply: Allow safe usage of power supply
In-Reply-To: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <13686747.WJugMFr0nf@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 30. Januar 2015, 15:47:38 schrieb Krzysztof Kozlowski:
> Hi,
> 
> The patchset changes power supply API and drivers implementing
> power supply class.
> 
> 
> TLDR for driver and subsystem maintainers
> =========================================
> Two patches of patchset change power_supply_register() function so in
> the same time they touch all drivers. I am kindly asking for acks,
> review and help in testing.
> 
> Please look at:
>  - patch 2: power_supply: Move run-time configuration to separate structure
>  - patch 11: power_supply: Change ownership from driver to core
> 
> These are huge.

Patches 2 and 11 are Reviewed-By: Marc Dietrich <marvin24@gmx.de> # for the 
nvec part.

Thanks!

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/d038734b/attachment.sig>
