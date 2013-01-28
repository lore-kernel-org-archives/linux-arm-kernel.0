From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 20:18:17 +0000
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
In-Reply-To: <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201301282018.17714.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 January 2013, Thomas Petazzoni wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> 
> [Thomas Petazzoni:
>  - Simplify capabilities handling.
>  - Move to a separate file.
>  - Fix mask used when writing a 4 bytes value.]
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Not even a description why this is needed?

This patch (together with patch 8) seems like the most controversial
one of the series, so you should better provide a really good reason
why we would emulate something in software rather than using whatever
hardware is there.

	Arnd
