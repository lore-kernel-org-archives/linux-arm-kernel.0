From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 15 Aug 2018 00:19:08 +0300
Subject: [PATCH v2 1/5] ARM: trusted_foundations: Implement L2 cache
 initialization callback
In-Reply-To: <20180619110027.16935-2-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
 <20180619110027.16935-2-digetx@gmail.com>
Message-ID: <1581737.LbIJYaB7YW@dimapc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, 19 June 2018 14:00:23 MSK Dmitry Osipenko wrote:
> Implement L2 cache initialization firmware callback that should be invoked
> early in boot to enable cache HW.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/firmware/trusted_foundations.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Russell, could you please take a look at the arm/firmware/ patches and ACK 
them if they are good to you?
