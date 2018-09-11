From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 11 Sep 2018 10:26:32 +0800
Subject: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
In-Reply-To: <20180906183144.GD8607@kunai>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
 <20180906183144.GD8607@kunai>
Message-ID: <1536632792.22101.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-09-06 at 20:31 +0200, Wolfram Sang wrote:
> On Thu, Sep 06, 2018 at 09:15:28PM +0800, Jun Gao wrote:
> > From: Jun Gao <jun.gao@mediatek.com>
> > 
> > In order not to block the initializations of some i2c devices.
> > Register i2c adapter driver at appropriate time.
> > 
> > Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> 
> The reasons this patch was rejected in v2 still hold.
OK. Thanks for your opinion.
> 
