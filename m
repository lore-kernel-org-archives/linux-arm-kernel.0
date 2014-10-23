From: romain.perier@gmail.com (PERIER Romain)
Date: Thu, 23 Oct 2014 11:39:34 +0200
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <20141023081230.GK32045@tbergstrom-lnx.Nvidia.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
 <20141023081230.GK32045@tbergstrom-lnx.Nvidia.com>
Message-ID: <CABgxDoKm5kKKCTD1njAerUrM24iVcGRDuhJ7b4qBVPqKBC4ftQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

2014-10-23 10:12 GMT+02:00 Peter De Schrijver <pdeschrijver@nvidia.com>:
> This breaks DT ABI stability right? An existing device tree using ti,system-power-controller won't work anymore after this patch right? I don't think that's acceptable.
>

This is why I converted all dts which use "ti,system-power-controller"
and tps65910/tps65911 to the new property (everything is in the
patches serie). However, with an existing dtb it will no longer work,
yes.
What do you suggest ? keep these two properties in the driver ? :/

I mean, this is a standardization, so all the corresponding dts must
be updated and rebuilt... Like when you change something in a
dt-binding, you should update and rebuilt the dts... I Don't compute.

Romain
