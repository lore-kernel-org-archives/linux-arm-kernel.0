From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Jan 2017 01:54:55 -0800
Subject: [PATCH v2] drivers: remoteproc: constify rproc_ops structures
In-Reply-To: <1483267417-7850-1-git-send-email-bhumirks@gmail.com>
References: <1483267417-7850-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170102095455.GA22853@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 01 Jan 02:43 PST 2017, Bhumika Goyal wrote:

> Declare rproc_ops structures as const as they are only passed as an
> argument to the function rproc_alloc. This argument is of type const, so
> rproc_ops structures having this property can be declared const too.

Thanks Bhumika, applied.

Regards,
Bjorn
