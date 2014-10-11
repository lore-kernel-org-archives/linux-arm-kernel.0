From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Oct 2014 20:04:15 +0200
Subject: [PATCH v3 0/6] add basic rk3288 smp support
In-Reply-To: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
References: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <5162812.g00M9eGW9B@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Freitag, 10. Oktober 2014, 14:26:04 schrieb Kever Yang:
> rk3288 is qual-core CPU Soc, we enable the smp in this patch.
> 
> In version 3 we use regmap and pmu syscon for cpu power on/off.
> This should be work after Pankaj Dubey's patch applied:
> (https://lkml.org/lkml/2014/9/30/156)

I've tested this series on both a rk3188 as well as a rk3288 and was 
sucessfully getting the secondary cores bootet.

I did not include patch2 in this, as the whole thing also works when applying 
the syscon-patch I mention in an individual reply - which also already got 
accepted for 3.19.


Heiko
