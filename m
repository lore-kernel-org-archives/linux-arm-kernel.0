From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 22 May 2013 13:15:26 +0800
Subject: [PATCH v4] ASoC: dfbmcs320: make the driver common for other BT
 modules
In-Reply-To: <20130521181849.GG1627@sirena.org.uk>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
 <20130521181849.GG1627@sirena.org.uk>
Message-ID: <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/22 Mark Brown <broonie@kernel.org>:
> On Sat, May 18, 2013 at 08:25:00PM +0800, Barry Song wrote:
>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>> we don't want everyone to have a seperate codec driver. anyway, the
>> feature of Bluetooth SCO is same on all platforms, so this patch
>> makes the DFBM-CS320 driver become a common BT SCO link driver.
>
> Applied, thanks.

thanks, Mark. can we also do something in omap-hdmi to make the HDMI
codec common as well?
i think it is in the same situation with BT SCO:
http://comments.gmane.org/gmane.linux.alsa.devel/108234

-barry
