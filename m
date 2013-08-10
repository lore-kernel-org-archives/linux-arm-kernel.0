From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 19:18:58 +0200
Subject: [PATCH v2 00/11] dma: pdma: some patches needed for PXA DT
 environments
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <52067602.5040901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.08.2013 18:52, Daniel Mack wrote:
> This is v2 of my series to add more features to the pdma driver.

I forgot to mention that this series depends on a patch from Zhangfei
Gao which provides dma_get_slave_channel(). It was posted here:

  http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
