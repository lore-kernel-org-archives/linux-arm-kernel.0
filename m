From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  7 Sep 2016 22:09:55 +0200
Subject: [PATCH resend fixes for 4.8 0/2] input: touchscreen: silead_gsl1680:
 fixes
Message-ID: <20160907200957.3341-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

Here are 2 fixes for the silead touchscreen driver which is new in 4.8,
since these change firmware loading behavior (*) we really ought to get
these into 4.8, so that don't end up shipping a stable kernel with the
old firmware loading behavior.

Note the small dt binding change this includes has been acked by
Robh, so these 2 are ready for merging now.

Thanks & Regards,

Hans
