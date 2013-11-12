From: lho@apm.com (Loc Ho)
Date: Mon, 11 Nov 2013 21:19:41 -0800
Subject: [PATCH v2 3/5] ata: Add APM X-Gene SATA driver
In-Reply-To: <201311110954.32904.arnd@arndb.de>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <1383980431-6572-4-git-send-email-lho@apm.com>
 <CAOesGMjEpC9-i52zYb2LtmyfV7FZQQGeeo4Umg-LXOYytZ4E-A@mail.gmail.com>
 <201311110954.32904.arnd@arndb.de>
Message-ID: <CAPw-ZT=aVyw2yducpQMD2_rPPV7abKJZOH-Fs3bT2Ja=0tUNSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

I looked over the phy code for USB and NET. There isn't such PHY
infrastructure for SATA from what I can tell. It seems like I will
need to put this all together. I am thinking about porting the USB
version over (with changes for SATA) and put it under
"./drivers/ata/phy". Any suggestion?

-Loc
