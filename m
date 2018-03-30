From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 16:16:13 +0800
Subject: [linux-sunxi] [PATCH v2 08/10] ARM: sun8i: h3: Add SY8106A
 regulator to Orange Pi PC
In-Reply-To: <20180206044905.30508-9-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-9-icenowy@aosc.io>
Message-ID: <CAGb2v65_w4LY-5RJqZN2+Rd3jwnD2upJovibgnUY2FrPwVPROw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 6, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
> Orange Pi PC, then set the power supply of the ARM cores to this
> regulator, in order to enable DVFS.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
