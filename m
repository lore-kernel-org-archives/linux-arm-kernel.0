From: pengbo.mu@nxp.com (Pengbo Mu)
Date: Tue, 31 Jul 2018 02:46:28 +0000
Subject: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type
 adjustment
In-Reply-To: <87a7qe1cds.fsf@linux.intel.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
 <87a7qe1cds.fsf@linux.intel.com>
Message-ID: <AM0PR0402MB374720F0D369137620BEEEB7F42E0@AM0PR0402MB3747.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi [mailto:balbi at kernel.org] writes:
> > Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0
> > DWC3.When only one value means INCRx mode with fix burst type.
> > When more than one value, means undefined length burst mode, USB
> > controller can use the length less than or equal to the largest
> > enabled burst length.
> >
> > While enabling undefined length INCR burst type and INCR16 burst type,
> > get better write performance on NXP Layerscape platforms: around 3%
> > improvement (from 364MB/s to 375MB/s).
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
> 
> will this go through arm64 tree or do you need me to pick it up?

Hi ,
I am sorry for I don't understand what you mean .
This patch fixed the dts files of arm32 & arm64 , so I named the title like "arm: arm64: dts ***" .
Is this something wrong ? If yes , pls tell me and I will fix it !

Thanks,
Pengbo 
