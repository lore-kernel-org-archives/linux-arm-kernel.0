From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Dec 2015 08:04:24 -0600
Subject: [PATCH V2 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC
 TPS65217
In-Reply-To: <20151216134541.GA5574@afzalpc>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-2-git-send-email-nm@ti.com> <20151215135100.GA8288@afzalpc>
 <CAGo_u6pGcKoz_Vw9hWtuDJ8RBr+N4=G0p5RgEAcjheoe4VXhvQ@mail.gmail.com>
 <20151216134541.GA5574@afzalpc>
Message-ID: <56716F68.6090701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 07:45 AM, Afzal Mohammed wrote:
[...]
> Changelog refers to old beagle bone's, does new ones have a different
> PMIC ?, i only have white bones ;)


Blacks seem to boot (see cover-letter) - could be because of default
configuration of tps65217. From my test log:
11:    beaglebone-black: BOOT: PASS: err=4 warn=13:
http://pastebin.ubuntu.com/14008272/

-- 
Regards,
Nishanth Menon
