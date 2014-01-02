From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  2 Jan 2014 10:58:23 +0100
Subject: [PATCH v2 0/4] input: Add new sun4i-lradc-keys driver
Message-ID: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dimitri et al,

Here is v2 of the sun4i-lradc-keys driver, changes since v1:

- Use include/dt-bindings/input/input.h
- Rename the keycodes property to linux,chan0-keycodes

Regards,

Hans
