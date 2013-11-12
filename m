From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Nov 2013 14:11:53 +0100
Subject: [PATCH v2 3/5] ata: Add APM X-Gene SATA driver
In-Reply-To: <CAPw-ZT=aVyw2yducpQMD2_rPPV7abKJZOH-Fs3bT2Ja=0tUNSQ@mail.gmail.com>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <201311110954.32904.arnd@arndb.de>
 <CAPw-ZT=aVyw2yducpQMD2_rPPV7abKJZOH-Fs3bT2Ja=0tUNSQ@mail.gmail.com>
Message-ID: <201311121411.54423.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 November 2013, Loc Ho wrote:
> Hi Arnd/Olof,
> 
> I looked over the phy code for USB and NET. There isn't such PHY
> infrastructure for SATA from what I can tell. It seems like I will
> need to put this all together. I am thinking about porting the USB
> version over (with changes for SATA) and put it under
> "./drivers/ata/phy". Any suggestion?

Please have a look at the patches under the subject "Generic PHY Framework"
posted by Kishon Vijay Abraham. I thought they would have made it in
by now, but I have not followed the recent kernels closely since I am
on parental leave at the moment.

IIRC they should unify USB, SATA and other PHY codes, but not network.

	Arnd
