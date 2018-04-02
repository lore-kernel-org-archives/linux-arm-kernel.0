From: davem@davemloft.net (David Miller)
Date: Mon, 02 Apr 2018 11:14:34 -0400 (EDT)
Subject: [PATCH v3 0/2] net: mvneta: improve suspend/resume
In-Reply-To: <20180402112229.508e1feb@xhacker.debian>
References: <20180402112229.508e1feb@xhacker.debian>
Message-ID: <20180402.111434.124774623285634501.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Mon, 2 Apr 2018 11:22:29 +0800

> This series tries to optimize the mvneta's suspend/resume
> implementation by only taking necessary actions.
> 
> Since v2:
>  - keep rtnl lock when calling mvneta_start_dev() and mvneta_stop_dev()
>    Thank Russell for pointing this out
> 
> Since v1:
>  - unify ret check
>  - try best to keep the suspend/resume behavior
>  - split txq deinit into sw/hw parts as well
>  - adjust mvneta_stop_dev() location

Series applied, thank you.
