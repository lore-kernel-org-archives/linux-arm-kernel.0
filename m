From: davem@davemloft.net (David Miller)
Date: Thu, 12 Jan 2017 23:16:37 -0500 (EST)
Subject: [PATCH net-next v2 05/10] drivers: base: Add device_find_class()
In-Reply-To: <81f5965c-3484-92d9-5c04-94c5b73735d0@gmail.com>
References: <20170112034121.27697-6-f.fainelli@gmail.com>
 <20170112.162135.441956368122992032.davem@davemloft.net>
 <81f5965c-3484-92d9-5c04-94c5b73735d0@gmail.com>
Message-ID: <20170112.231637.1459914337755928344.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 12 Jan 2017 14:50:39 -0800

> Well, this is really so that we don't need to cast the arguments passed
> to device_find_child(), which takes a void *data as well.

Aha, I didn't catch that, my bad.
