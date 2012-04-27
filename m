From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 27 Apr 2012 08:37:14 +0000
Subject: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
In-Reply-To: <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>	<87aa1ybaxf.fsf@ti.com>
 <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA007DC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 02:13:10, Dill, Russ wrote:
> On Thu, Apr 26, 2012 at 11:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >
> >
> > If so, please reply with your Tested-by.
> 
> Tested-by: Russ Dill <Russ.Dill@ti.com>
> 
> All three patches in series boot tested on:
> Beagleboard xM
> Beagleboard B4
> Mistral AM37X-EVM
> 

Thanks Russ, helping me out in validating this. I have also tested it on 
AM37xEVM platform and can conform that this fixes the issue.

Thanks,
Vaibhav
