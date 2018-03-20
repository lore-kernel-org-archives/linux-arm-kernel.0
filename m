From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 17:53:43 -0700
Subject: =?utf-8?q?Re=3A_=5BPATCH_v8_00/42=5D_ARM=3A_davinci=3A_convert_to_common_?=
 =?utf-8?q?clock_framework=E2=80=8B?=
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:16)
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 19 patches create new clock drivers
> using the common clock framework. There are basically 3 groups of clocks -
> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
> unique init data, which is the reason for so many patches.

Should I apply the first 19 patches to clk tree? Looking over them
nothing stands out except for your self comment about the bad
reviewed-by tag which I can remove.
