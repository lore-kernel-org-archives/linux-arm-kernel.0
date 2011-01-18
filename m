From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 18 Jan 2011 14:41:13 +0300
Subject: [PATCH 0/5] davinci: da850: clean up pinmux arrays in da850.c
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734D4@dbde02.ent.ti.com>
References: <1294406333-30054-1-git-send-email-michael.williamson@criticallink.com>	<B85A65D85D7EB246BE421B3FB0FBB59302484733F8@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302484734D4@dbde02.ent.ti.com>
Message-ID: <4D357C59.8000907@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-01-2011 7:40, Rajashekhara, Sudhakar wrote:

> I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> at [1] and found that audio is broken. Below patch fixes the issue.

> ---
> From: Rajashekhara, Sudhakar<sudhakar.raj@ti.com>

> davinci: fixes for audio on da850/omap-l138/am18x
>
> On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> has the wrong AIC3x codec slave address. This patch fixes this issue.

> Also, this patch registers the platform device for davinci-pcm-audio.

    Shouldn't this be 2 patches? I don't see a connection between the changes.

> Signed-off-by: Rajashekhara, Sudhakar<sudhakar.raj@ti.com>

WBR, Sergei
