From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 02 Dec 2015 11:09:15 +0300
Subject: [PATCH 3/6] net: thunderx: Increase transmit queue length
In-Reply-To: <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
References: <y@samsung.com>
 <1448961223-41888-4-git-send-email-sunil.kovvuri@gmail.com>
 <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
 <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <00b101d12cd8$bd34fea0$379efbe0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > swiotlb: coherent allocation failed for device 0002:01:08.4 size=4198400
> > CPU: 2 PID: 3655 Comm: NetworkManager Tainted: G        W  O    4.2.6+ #201
> > Hardware name: Cavium ThunderX CN88XX
> 
> Are you sure 4.2.6 kernel is suitable for backporting this patch aimed
> for linux-4.5 ?

 Why not? It's just a networking driver. And, i also have the same problem on 4.3 running as KVM guest with VFIO.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
