From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Dec 2015 12:05:39 +0800
Subject: [PATCH 1/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
In-Reply-To: <1449779521-754-2-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
 <1449779521-754-2-git-send-email-merker@debian.org>
Message-ID: <CAGb2v67qON+NR=OsczUgx6uPXfitJJjErVOk2g4wivnYzxHT=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 4:31 AM, Karsten Merker <merker@debian.org> wrote:
> The Olimex A20-SOM-EVB is an evaluation board for the Olimex
> A20-SOM system-on-module.  It provides a set of android-style
> buttons (labeled "VOL+", "VOL-", "MENU", "SEARCH", "HOME", "ESC"
> and "ENTER") which are connected to a low-resolution ADC via a
> resistor network.
>
> This patch adds appropriate button definitions to the board
> dts. The voltages assigned to the keys are specified in the
> board schematics published by the manufacturer.
>
> Signed-off-by: Karsten Merker <merker@debian.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
