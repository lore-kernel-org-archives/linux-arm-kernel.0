From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:41:23 +0000
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395314713.7776.17.camel@joe-AO722>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722>
Message-ID: <20140320114123.GE21349@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014, Joe Perches wrote:

> On Thu, 2014-03-20 at 11:11 +0000, Lee Jones wrote:
> > Reported-by: Brian Norris <computersforpeace@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Why are these useless?
> 
> Even if the object code produced is the same,
> these serve as information to the human reader
> about how the arguments are used.

https://lkml.org/lkml/2014/3/20/69

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
