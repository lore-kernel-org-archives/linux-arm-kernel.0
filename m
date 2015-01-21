From: andreas2025@gmail.com (Andy Ng)
Date: Wed, 21 Jan 2015 10:27:35 +0000
Subject: Unregisrtering a platform driver from another platform driver.
Message-ID: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Colleagues,

I would like to call "platform_driver_unregister" for a static module
A from a static  module B.
The static module A register its name  "physmap-flash".

Is there any kernel API to search and find the "physmap-flash" device,
and then call unregistered with "platform_driver_unregister" from
module B.

Any advice will be very much appreciated.

Best regards
A
