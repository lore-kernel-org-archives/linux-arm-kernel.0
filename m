From: miloody@gmail.com (loody)
Date: Thu, 4 Oct 2012 14:38:54 +0800
Subject: some question about armv7 cache operations
In-Reply-To: <CANudz+sbFPunRXGm9ehapd51zJ9ucbYvH0E_eAUQTHrP9cwDGw@mail.gmail.com>
References: <CANudz+sbFPunRXGm9ehapd51zJ9ucbYvH0E_eAUQTHrP9cwDGw@mail.gmail.com>
Message-ID: <CANudz+sh1V_RKQ1kV4zK+WCpnrNxHvNM95AfruPndvUYODcjkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
After studying Arm v7 document and trace kernel source code, I cannot
find any instruction which can tell us the tag and data value at
specific index/way.
Take v7 data cache for example,
we use
MCR     p15, 0, r11, c7, c6, 2

to invalidate data cache by set/way, where r11 put set/way format.

but if I need to know the tag/data value in set/way what r11 content,
is there any command I can adopt?

--
Regards,


-- 
Regards,
