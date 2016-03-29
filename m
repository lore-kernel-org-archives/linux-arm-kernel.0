From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2016 00:30:03 +0200
Subject: [PATCH] arm64: dts: vulcan: Update PCI ranges
In-Reply-To: <56E3278F.5090200@gmail.com>
References: <56D200F5.7010505@broadcom.com>
 <1456645037-12978-1-git-send-email-jchandra@broadcom.com>
 <56E3278F.5090200@gmail.com>
Message-ID: <163715315.6u7avlh5g3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2016 12:16:15 Florian Fainelli wrote:
> On 27/02/16 23:37, Jayachandran C wrote:
> > The PCI memory windows available in vulcan.dtsi are limited to 128MB
> > for 32-bit BARs, and 4GB for 64-bit BARs. Given the memory mapped IO
> > space available in arm64, these windows can be increased substantially
> > to support more use cases.
> > 
> > The change increases the 32-bit window to 256MB and the 64-bit window
> > to 128 GB. The firmware on vulcan boards will use these ranges as well.
> > 
> > PCI IO windows are not supported on Vulcan, so remove them instead of
> > keeping an unused value.
> > 
> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > ---
> > 
> > This is an update to the patch with subject
> > "arm64: Broadcom Vulcan support"
> > I had sent earlier, please fold it into that patch if possible
> 
> Arnd, I do not have any other Broadcom ARM64 DT changes for 4.6 to be
> sent at the moment, do you mind taking this patch directly?
> 
> Feel free to add my:
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> 

Applied to the 4.6 fixes branch now, thanks!

	Arnd
