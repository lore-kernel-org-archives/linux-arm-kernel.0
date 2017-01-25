From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 10:31:45 +0100
Subject: [PATCH] ARM: dts: tegra: =?utf-8?Q?Fix?=
 =?utf-8?Q?_missing_card_detection_in_Trimslice_=C2=B5SD?= card slot
In-Reply-To: <20170122211747.exirq4nvb2xj6dk6@localhost>
References: <20170122211747.exirq4nvb2xj6dk6@localhost>
Message-ID: <20170125093145.GF13025@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 10:17:48PM +0100, Rask Ingemann Lambertsen wrote:
> Card insertion and removal currently goes undetected. AFAIK there's no
> way to generate interrupts on card changes in this slot, so use polling.
> 
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> ---
>  arch/arm/boot/dts/tegra20-trimslice.dts | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/d5e289bd/attachment.sig>
