From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 8 Jul 2011 13:14:35 +0400
Subject: [PATCH 2/2] arch: arm: CNS3xxx select the correct CPU type CPU_V6K
In-Reply-To: <1310104806-12984-1-git-send-email-tommy.lin@caviumnetworks.com>
References: <1310104806-12984-1-git-send-email-tommy.lin@caviumnetworks.com>
Message-ID: <20110708091435.GB15142@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 02:00:06PM +0800, Tommy Lin wrote:
> ARM11        -> CPU_V6
> ARM11 MPCore -> CPU_V6K
> CNS3xxx has ARM11 MPCore CPUs (dual core), but initially select the same single
> core CPU type. To select MPCore watchdog support, this patch correts the CPU
> type from CPU_V6 to CPU_V6K.
> 
> Signed-off-by: Tommy Lin <tommy.lin@caviumnetworks.com>
> ---

Imre Kaloz sent a similar patch yesterday:

http://www.spinics.net/lists/arm-kernel/msg131933.html

Which is now in the linux-cns3xxx.git tree.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
