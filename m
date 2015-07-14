From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 14 Jul 2015 09:26:00 -0700
Subject: mx6: suspicious RCU usage
In-Reply-To: <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
References: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
 <20150714160006.GI3717@linux.vnet.ibm.com>
 <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
Message-ID: <20150714162600.GJ3717@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 01:06:32PM -0300, Fabio Estevam wrote:
> Hi Paul,
> 
> On Tue, Jul 14, 2015 at 1:00 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Does this patch help?
> >
> >         https://lkml.org/lkml/2015/5/12/885
> 
> I am using an ARM 32-bit machine, so I used this one instead:
> https://lkml.org/lkml/2015/5/12/892
> 
> , and it fixes the problem. Thanks!
> 
> Feel free to add:
> 
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Glad it helped!

Russell, did you want me to push this, or would you rather take it?

							Thanx, Paul
