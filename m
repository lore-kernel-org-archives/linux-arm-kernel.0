From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 01 Dec 2015 07:33:05 -0800
Subject: [PATCH 3/6] net: thunderx: Increase transmit queue length
In-Reply-To: <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
References: <y@samsung.com>
 <1448961223-41888-4-git-send-email-sunil.kovvuri@gmail.com>
 <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
Message-ID: <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-01 at 17:40 +0300, Pavel Fedin wrote:
>  Hello!
> 
>  This one breaks networking on my machine:
> --- cut ---
> swiotlb: coherent allocation failed for device 0002:01:08.4 size=4198400
> CPU: 2 PID: 3655 Comm: NetworkManager Tainted: G        W  O    4.2.6+ #201
> Hardware name: Cavium ThunderX CN88XX

Are you sure 4.2.6 kernel is suitable for backporting this patch aimed
for linux-4.5 ?
