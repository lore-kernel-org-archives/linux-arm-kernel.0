From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 24 Mar 2014 11:58:44 -0700
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <1395385319-25386-1-git-send-email-chao.xie@marvell.com> (Chao
 Xie's message of "Fri, 21 Mar 2014 15:01:58 +0800")
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
Message-ID: <7hr45ra0ez.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao Xie <chao.xie@marvell.com> writes:

> PJ4 is based on V7, but it has some changes. For example, some
> coprocessor settings.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

For this updated series:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

Can you submit this to Russell's patch tracking system ASAP please so we
can fix the multiple boot failures we're seeing in -next.

Thanks,

Kevin

[1] http://www.arm.linux.org.uk/developer/patches/
