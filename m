From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu, 26 Jun 2014 09:32:30 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <20140626031247.GN2224@dragon>
 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
Message-ID: <201406260932.30524.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thursday 26 June 2014 05:43:19 Fabio Estevam wrote:
> [...]
> Below is the log with linux-next kernel and earlyprintk enabled:

Does it also hang when you disable "earlyprintk"? A few weeks ago we had a 
similar issue with i.MX6/PCI and "earlyprintk" (at the end it was caused by a 
clock change for the UART when changing from the early to the regular 
console).

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| http://www.pengutronix.de/  |
