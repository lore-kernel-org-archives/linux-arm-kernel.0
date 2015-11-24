From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Tue, 24 Nov 2015 09:28:30 -0500
Subject: [PATCH 4/4] ARM: dts: vf610-twr: relicense vf610-twr.dts under
 GPLv2/X11
In-Reply-To: <1448323302-23563-1-git-send-email-stefan@agner.ch> (Stefan
 Agner's message of "Mon, 23 Nov 2015 16:01:42 -0800")
References: <1448323302-23563-1-git-send-email-stefan@agner.ch>
Message-ID: <87io4rv5dd.fsf@sympatico.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 Nov 2015, stefan at agner.ch wrote:

> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all
> necessary uses, so relicense the vf610-twr.dts file to this
> combination.
>
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf610-twr.dts
>
> CC: Bill Pringlemeir <bpringle@sympatico.ca>

Acked-by: Bill Pringlemeir <bpringle@sympatico.ca>

> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>
> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Jingchang Lu <b35083@freescale.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> arch/arm/boot/dts/vf610-twr.dts | 40
> ++++++++++++++++++++++++++++++++++++---- 1 file changed, 36
> insertions(+), 4 deletions(-)
