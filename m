From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 21 Mar 2012 16:41:20 +0100
Subject: [PATCH 0/3] atmel-mci fixes 
Message-ID: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patches provide some fixes for atmel-mci driver:
- data timeout calculation was not correct and can cause serious issues when
using a rootfs on the sd card.
- the r/w proof features is available only from 2xx hsmci version
- supports for odd clock dividers available from 5xx hsmci version

Regards

Ludovic
