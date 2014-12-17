From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Dec 2014 15:43:30 +0100
Subject: [PATCH resend v2] input: Add new sun4i-lradc-keys driver
Message-ID: <1418827411-13265-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

AFAIK everyone likes the new dt interface from v2, so this one should have
been merged, but it appears to have fallen through the cracks.

Can you please queue this up for 3.19 or 3.20 ?

Note this is an unmodified resend of the v2 I send a while back, for
completeness sake here is the changelog:

Changes in v2:
-Change devicetree bindings to use a per key subnode, like gpio-keys does

Thanks & Regards,

Hans
