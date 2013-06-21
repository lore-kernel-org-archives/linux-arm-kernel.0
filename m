From: dsd@laptop.org (Daniel Drake)
Date: Fri, 21 Jun 2013 11:13:03 -0600
Subject: [V2 4/7] video: mmp: fix memcpy wrong size for mmp_addr issue
In-Reply-To: <1370879562-11342-1-git-send-email-jtzhou@marvell.com>
References: <1370879562-11342-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAMLZHHQL+TmwA1pYOsHp8E=B4q3D65O=0F=pQWfmxBuQwDbS=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Jing Xiang <jxiang@marvell.com>
>
> Memcpy used wrong struct of mmp_win, fix it.
>
> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>

Reviewed-by: Daniel Drake <dsd@laptop.org>
