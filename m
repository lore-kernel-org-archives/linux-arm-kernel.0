From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 09 Dec 2013 11:09:31 +0100
Subject: [linux-sunxi] Re: [PATCH 01/10] net: stmmac: Enable stmmac main
 clock when probing hardware
In-Reply-To: <CAGb2v65YOSq_BMWSzSHX8w_hbo+0vwquBT2pnLuwNVZkWRfLvA@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-2-git-send-email-wens@csie.org>
 <20131207103335.GL24519@lukather>
 <CAGb2v65YOSq_BMWSzSHX8w_hbo+0vwquBT2pnLuwNVZkWRfLvA@mail.gmail.com>
Message-ID: <52A596DB.7040001@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

It seems this patch is not enough, gmac won't work for me
with this patchset (*), unless I boot with an uboot which
also has the gmac patches.

Regards,

Hans


*) see my sunxi-test tree where I've dropped your
old version and added this version.
