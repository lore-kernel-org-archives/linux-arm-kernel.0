From: tj@kernel.org (Tejun Heo)
Date: Tue, 27 May 2014 09:35:24 -0400
Subject: [PATCH] ata: ep93xx: use dmaengine_prep_slave_sg api instead of
 internal callback
In-Reply-To: <1401009545-31925-1-git-send-email-21cnbao@gmail.com>
References: <1401009545-31925-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140527133524.GB22767@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 05:19:05PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> it is better to use generic api instead of calling an internal callback
> like channel->device->device_prep_slave_sg().
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
