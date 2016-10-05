From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  5 Oct 2016 17:51:11 +0200
Subject: [PATCH 0/1] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Message-ID: <20161005155112.13774-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Dennis Gilmore (in the Cc) reports that axp20x-i2c does not auto-load
on e.g. the CHIP. I believe this is caused by the i2c-ids table not being
populated.

I believe the patch in the next mail should fix this.

Regards,

Hans
