From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Aug 2017 12:21:11 -0400 (EDT)
Subject: [PULL REQUEST] FDPIC ELF support on ARM
In-Reply-To: <alpine.LFD.2.20.1708081236150.8927@knanqh.ubzr>
References: <alpine.LFD.2.20.1708081236150.8927@knanqh.ubzr>
Message-ID: <alpine.LFD.2.20.1708101216520.8927@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Aug 2017, Nicolas Pitre wrote:

> Russell, please pull the following:
> 
>     http://git.linaro.org/people/nicolas.pitre/linux fdpic
> 
> This series provides the needed changes to enable the ELF_FDPIC
> binary format on ARM. Currently only no-MMU configs are supported
> but eventually adding MMU support is trivial.

Please don't merge this just yet. There are issues with the signal code 
not compatible with ARMv4t interworking that I fixed. I'm also adding 
the MMU support so test coverage will be better.


Nicolas
