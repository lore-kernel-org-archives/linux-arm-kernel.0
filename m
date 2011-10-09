From: michael@walle.cc (Michael Walle)
Date: Sun, 9 Oct 2011 15:45:55 +0200
Subject: orion/kirkwood and device tree support
Message-ID: <201110091545.55645.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear orion/kirkwood maintainers,

I submitted a patch to support the Buffalo LS-XHL three months ago, which was 
rejected because no more old fashioned board setup patches will be merged. 

Are there any plans or even ongoing developments to convert these platforms to 
support device trees?

What is the best way to convert the {orion,kirkwood}_*_init() calls to DT? 
Make each device use a device_driver structure for initialization?

-- 
Michael
