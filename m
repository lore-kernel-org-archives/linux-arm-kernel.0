From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 7 May 2015 21:22:04 +0200
Subject: [PATCH] xen/arm: Define xen_arch_suspend()
In-Reply-To: <1431017723-27194-1-git-send-email-boris.ostrovsky@oracle.com>
References: <1431017723-27194-1-git-send-email-boris.ostrovsky@oracle.com>
Message-ID: <CAOMqctS6gZp=yObN3XLPorT0ZzBAA0EX2oapxvNnbCUAehqt-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2015 at 18:55, Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:
> Commit 2b953a5e994c ("xen: Suspend ticks on all CPUs during suspend")
> introduced xen_arch_suspend() routine but did so only for x86, breaking
> ARM builds.
>
> We need to add it to ARM as well.
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Reported-by: Michal Suchanek <hramrach@gmail.com>
> Tested-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Tested-by: Michal Suchanek <hramrach@gmail.com>

Thanks
