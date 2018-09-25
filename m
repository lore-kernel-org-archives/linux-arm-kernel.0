From: rodrigo@tjader.xyz (=?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?=)
Date: Tue, 25 Sep 2018 14:47:59 -0300
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <20180925090139.qbu6tqav5oth7zkw@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
Message-ID: <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> We can't really do that, unfortunately. If the device tree name was to
> change for a given board, we'd break all the build systems, boot
> scripts and distros out there.

What if we keep the device tree for the version without WiFi and eMMC
with the current name and create new device trees for the other two
versions?
