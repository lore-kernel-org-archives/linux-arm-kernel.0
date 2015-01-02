From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Jan 2015 09:38:45 -0600
Subject: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <54A66143.2080506@gmail.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>	<1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>	<54A19C17.1020909@ti.com>
 <CA+Ln22G3kVA_-tsjAxbe2rqSHeLtdU2X_EhNL0uW3cUCgaWLgg@mail.gmail.com>
 <54A2BBDC.1020900@ti.com> <54A66143.2080506@gmail.com>
Message-ID: <54A6BB85.70805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2015 03:13 AM, Tomasz Figa wrote:

> However I'm not sure about your concern about using l2x0_data before 
> kmemdup(). I don't see any code potentially doing this.

It is not terribly important, but anyways [1] is what I had in mind..



[1]
https://github.com/nmenon/linux-2.6-playground/commit/40f65e4707856f7b35872cf2225bf8beaf43552c#diff-56925866b8b499d75763bf5a1d7f1666L883

-- 
Regards,
Nishanth Menon
