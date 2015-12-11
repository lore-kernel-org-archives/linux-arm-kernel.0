From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Dec 2015 12:07:11 +0800
Subject: [PATCH 2/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3
 (baseboard SD socket)
In-Reply-To: <1449779521-754-3-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
 <1449779521-754-3-git-send-email-merker@debian.org>
Message-ID: <CAGb2v66SpWJkq-gRFX-JW1NuNJExdUc3OZJaS-WrLOa9zt5AQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 4:32 AM, Karsten Merker <merker@debian.org> wrote:
> The Olimex A20-SOM-EVB is an evaluation board for the Olimex
> A20-SOM system-on-module. The baseboard provides a full-size SD
> socket (connected to mmc3) in addition to the micro-SD socket on
> the SOM itself (which is connected to mmc0).
>
> Enable the mmc3 controller in the dts.
>
> Signed-off-by: Karsten Merker <merker@debian.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
