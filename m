From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 15:17:56 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.3 (part 2, try2)
In-Reply-To: <1439063444-12466-1-git-send-email-f.fainelli@gmail.com>
References: <55C4E8C8.7030503@broadcom.com>
 <1439063444-12466-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150811131756.GI30181@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sat, Aug 08, 2015 at 12:50:44PM -0700, Florian Fainelli wrote:
> The following changes since commit 39aa437e18cac7acae55481ed73feea0de497399:
> 
>   Merge branch 'queue/irq/arm' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into next/cleanup (2015-08-05 17:24:11 +0200)
> 
> are available in the git repository at:
> 
>   http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/soc-part2
> 
> for you to fetch changes up to cf1140515b3b94ef5aa06a085e94ddd814a8cd78:
> 
>   ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE (2015-08-06 21:38:13 -0700)

Same thing here, please don't base your branch on top of our next/*. I've also
cherry-picked these patches over, so no need to respin this time.


Thanks,

-Olof
