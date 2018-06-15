From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 15 Jun 2018 14:42:46 -0700
Subject: [PATCH v3 16/27] docs: Fix more broken references
In-Reply-To: <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
Message-ID: <152909896651.16708.13481357388390831455@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mauro Carvalho Chehab (2018-06-14 09:09:01)
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix
> 
> Manually checked that produced results are valid.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/clock/st/st,clkgen.txt |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt      |  2 +-
>  .../devicetree/bindings/clock/ti/interface.txt |  2 +-

Acked-by: Stephen Boyd <sboyd@kernel.org>
