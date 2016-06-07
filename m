From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 07 Jun 2016 01:37:51 -0700
Subject: [PATCH 30/34] clk: stm32f3: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <8dcaca11-b193-64d2-8fa6-7f3f031b328b@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-31-stephen.boyd@linaro.org>
 <8dcaca11-b193-64d2-8fa6-7f3f031b328b@linaro.org>
Message-ID: <146528867149.28742.13230988204794474162@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Daniel Thompson (2016-06-06 06:48:01)
> On 02/06/16 00:15, Stephen Boyd wrote:
> 
> Minor nit but the subject is wrong [IIRC stm32f3 cannot run Linux ;-)].
> 

Heh thanks. I'll fix it to be stm32f4 when applying.
