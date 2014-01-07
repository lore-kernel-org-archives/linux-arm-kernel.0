From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  7 Jan 2014 18:57:30 +0100
Subject: [PATCH v2 1/2] phy-core: 2 small fixes
Message-ID: <1389117452-3272-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Here is v2 of my phy-core patches. I've decided to fix the undesired error
logging problem by simple removing error logging from the core. IMHO
error-logging should be left to the drivers calling the core.

Thanks & Regards,

Hans
