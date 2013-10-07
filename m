From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 07 Oct 2013 00:58:31 -0700
Subject: [PATCH v5 3/3] Documentation: Add documentation for APM X-Gene
 clock binding
In-Reply-To: <CAPw-ZT=8TL2bJABd6_76JyZcDS+NTk+vJzj0YCGNNujKx+JqOA@mail.gmail.com>
References: <1372269371-22992-1-git-send-email-lho@apm.com>
 <1372269371-22992-2-git-send-email-lho@apm.com>
 <1372269371-22992-3-git-send-email-lho@apm.com>
 <1372269371-22992-4-git-send-email-lho@apm.com>
 <20130725205953.7598.15913@quantum>
 <CAPw-ZT=8TL2bJABd6_76JyZcDS+NTk+vJzj0YCGNNujKx+JqOA@mail.gmail.com>
Message-ID: <20131007075831.7445.49431@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Loc Ho (2013-07-31 11:49:07)
>    With the latest version, this is used to determine whether it is
>    divider register or csr register. In the file clk-xgene.c, grep for
>    "div-reg". It is around line 521.

Thanks for the rework, I've taken this for 3.13.

Regards,
Mike
