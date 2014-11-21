From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 21 Nov 2014 14:10:36 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <546F2BA4.4000808@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
 <20141120144028.GB5809@localhost.localdomain>
 <546F2BA4.4000808@ti.com>
Message-ID: <20141121131036.GA18931@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 05:40:12PM +0530, Sekhar Nori wrote:
> Not sure how to reproduce the jumping on pen-up.

Does the cursor stay in exactly the same spot when you lift up the
stylus? Then you don't have the issue.

On the BB white using the LCD4 cape and the shipped debian kernel, the
cursor *does* jump away, but not as often or as far as on the custom
design I was working with.

Thanks,
Richard
