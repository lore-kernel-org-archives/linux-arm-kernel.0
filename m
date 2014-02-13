From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 13 Feb 2014 14:41:59 +0800
Subject: [PATCH 0/3] clk: mmp: bug fix for clk-frac
In-Reply-To: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
References: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
Message-ID: <CADApbegKTak7Ja2P2TSm4vQy7Yx550ZARsc1jh7hQSohnQL0yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Mike
How about these fix patches?

On Thu, Jan 23, 2014 at 10:47 AM, Chao Xie <chao.xie@marvell.com> wrote:
> From: Chao Xie <chao.xie@marvell.com>
>
> When use the clk-frac type of mmp, some bugs are found.
> The following 3 patches are bug fix for clk-frac
>
> Chao Xie (3):
>   clk: mmp: fix wrong mask when calculate denominator
>   clk: mmp: fix the wrong calculation formula
>   clk: mmp: try to use closer one when do round rate
>
>  drivers/clk/mmp/clk-frac.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> --
> 1.8.3.2
>
