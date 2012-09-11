From: rubini@unipv.it (Alessandro Rubini)
Date: Tue, 11 Sep 2012 20:29:12 +0200
Subject: [PATCH 12/16] ARM: nomadik: move platform_data definitions
In-Reply-To: <1347368390-31252-12-git-send-email-arnd@arndb.de>
References: <1347368390-31252-12-git-send-email-arnd@arndb.de>
 <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <20120911182912.GA464@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the nomadik include directories

Acked-by: Alessandro Rubini <rubini@unipv.it>
