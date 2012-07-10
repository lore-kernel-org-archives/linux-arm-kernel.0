From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 14:44:36 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FFC190A.2040800@nvidia.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
Message-ID: <20120710134436.GD9409@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 05:29:06PM +0530, Laxman Dewangan wrote:

> Looked tps6586x-regulator driver and it has the platform data which
> is regulator_init_data.
> So for adding the vin-supply similar to what we have in fixed or
> tps6591x regulator to pass through the desc.supply_name, we are not
> having option here in platform data which can work for DT and non-DT
> case.

> So if still want to have the DT and non-DT case similar, we can add
> one tps6586x_regulator_platform_data as

The supply names are not supposed to be conditional (I realise they are
for your current DT patch, I let that in because I just want to see an
end to all this DT stuff).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/258f9afe/attachment.sig>
