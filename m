From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Jan 2015 17:23:39 +0800
Subject: [PATCH 2/2] sunxi: clk: Set sun6i-pll1 n_start = 1
In-Reply-To: <20150125155542.GF8470@lukather>
References: <1422100592-19981-1-git-send-email-hdegoede@redhat.com>
 <1422100592-19981-2-git-send-email-hdegoede@redhat.com>
 <20150125155542.GF8470@lukather>
Message-ID: <CAGb2v65DwNE4Q_R1uQdn97VemPKuNxK8bsbc6-whZ0xeD4T7yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 11:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jan 24, 2015 at 12:56:32PM +0100, Hans de Goede wrote:
>> For all pll-s on sun6i n == 0 means use a multiplier of 1, rather then 0 as
>> it means on sun4i / sun5i / sun7i. n_start = 1 is already correctly set
>> for sun6i pll6, but was missing for pll1, this commit fixes this.
>>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied the two, thanks!

This is the same as the one I sent, which you asked Mike to queue
for 3.19.

ChenYu
