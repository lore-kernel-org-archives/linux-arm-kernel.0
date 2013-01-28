From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 23:09:59 +0100
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
In-Reply-To: <201301282018.17714.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de>
Message-ID: <20130128230959.45cb503e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 28 Jan 2013 20:18:17 +0000, Arnd Bergmann wrote:

> Not even a description why this is needed?
> 
> This patch (together with patch 8) seems like the most controversial
> one of the series, so you should better provide a really good reason
> why we would emulate something in software rather than using whatever
> hardware is there.

Hum, you're right. In fact, the very reason why I'm adding an emulated
host bridge and emulated PCI-to-PCI bridges is simply because this was
one of the main suggestion raised during the review of the first
revision of this patch set.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
