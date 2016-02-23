From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Feb 2016 18:46:23 +0100
Subject: [PATCH v4 0/3] reset: Add support for shared reset controls
Message-ID: <1456249586-12101-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v4 of my shared reset-controls patch.

Changes in v3:
-Rewrite as result of mailinglist discussions changing the API

Changes in v4:
-Improve documentation for shared reset-controls
-Move WARN_ON(foo) to inside if () conditions

Regards,

Hans
