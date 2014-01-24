From: olof@lixom.net (Olof Johansson)
Date: Thu, 23 Jan 2014 18:11:32 -0800
Subject: [PATCH] ARM: moxart: DT fixups
In-Reply-To: <1390317973-24110-1-git-send-email-jonas.jensen@gmail.com>
References: <1390317973-24110-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140124021132.GB17877@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 04:26:13PM +0100, Jonas Jensen wrote:
> Change DT files to remain coherent with changes in
> accompanying drivers.
> 
> 1. replace "sdhci" with "mmc"
> 2. add bus-width property to mmc node
> 3. drop device_type property
> 4. replace "mac@" with "ethernet@"
> 5. replace CONFIG_MMC_SDHCI_MOXART with CONFIG_MMC_MOXART
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
> 
> Notes:
>     Applies on top of:
>     
>     "[PATCH] ARM: moxart: move fixed rate clock child node to board level dts"
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226141.html
>     
>     Applies to next-20140121

Since the prereqs for this patch are in different branches right now, I'll have
to apply it after the merges have been done by Linus. I'll include it in
a batch of fixes later on -- remind me if we forget.


-Olof
