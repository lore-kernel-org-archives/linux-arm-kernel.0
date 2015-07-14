From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 13:06:32 -0300
Subject: mx6: suspicious RCU usage
In-Reply-To: <20150714160006.GI3717@linux.vnet.ibm.com>
References: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
 <20150714160006.GI3717@linux.vnet.ibm.com>
Message-ID: <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Jul 14, 2015 at 1:00 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> Does this patch help?
>
>         https://lkml.org/lkml/2015/5/12/885

I am using an ARM 32-bit machine, so I used this one instead:
https://lkml.org/lkml/2015/5/12/892

, and it fixes the problem. Thanks!

Feel free to add:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
