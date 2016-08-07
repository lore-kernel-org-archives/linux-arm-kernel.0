From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  7 Aug 2016 21:02:37 +0200
Subject: [PATCH resend 0/1] mmc: pwrseq-simple: Add an optional
 post-power-on-delay
Message-ID: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, Rob,

Here is a resend of a patch from me from a couple of weeks ago.

There was some discussion about this back then, but if I understood
correctly, the end-conclusion was that Rob was ok with this change
(with the caveat that we should not add 6 more confgurable delays
at other points to the -simple binding later).

Rob have I understood that correctly, if so can we please have your
ack for the dt bits of this ?

Ulf can you review and if ok merge this once we've Rob's ack ?

Thanks & Regards,

Hans
