From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 23 Mar 2018 15:45:27 -0300
Subject: Regression with arm in next with stack protector
In-Reply-To: <20180323181452.GJ5799@atomide.com>
References: <20180323181452.GJ5799@atomide.com>
Message-ID: <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 5638790dadae ("zboot: fix stack protector in
> compressed boot phase") breaks booting on arm.

Yes, almost all imx are broken in linux-next due to this commit:
https://kernelci.org/soc/imx/job/next/kernel/next-20180323/
