From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 4 Apr 2017 16:35:05 +0900
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
Message-ID: <20170404073504.GI16309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 06:14:55AM -0000, David Woodhouse wrote:
> 
> > On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
> >>
> >> You still have typos here.
> >
> > I'd like to defer to the maintainers whether we prefer MiB over MB.
> 
> It is not really a matter of preference. One is correct; the other is not.
> 
> While simple errors can of course be forgiven, I cannot understand why you
> would deliberately repeat an error once it has been pointed out to you.

Because I think that people sometimes use those two interchangeably.
So I said I would defer to the maintainers.

-Takahiro AKASHI

> 
> 
> -- 
> dwmw2
> 
