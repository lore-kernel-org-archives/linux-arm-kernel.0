From: jett.zhou@gmail.com (jett zhou)
Date: Fri, 6 Jul 2012 09:59:56 +0800
Subject: [V3 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <20120705141541.GO4111@opensource.wolfsonmicro.com>
References: <20120621101536.GR4037@opensource.wolfsonmicro.com>
 <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
 <20120705142431.GD18200@sortiz-mobl>
 <20120705141541.GO4111@opensource.wolfsonmicro.com>
Message-ID: <CACDDiy8doUSiqzuE1NOYPErx3bDyKdVsXuyK_yX+pP90-h_MOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel, Mark
     Understood. I will split it into  MFD and a regulator (separate)
patches.
Thanks

2012/7/5 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Thu, Jul 05, 2012 at 04:24:31PM +0200, Samuel Ortiz wrote:
> > On Thu, Jun 21, 2012 at 07:31:23PM +0800, Jett.Zhou wrote:
>
> > > Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
> > > it needs to be enabled for charging battery, and will be disabled in
> > > some exception condition like over-temp.
>
> > Unless Mark already applied this patch, could you please split it into
> and MFD
> > and a regulator (separate) patches ?
>
> I've not applied it.
>



-- 

----------------------------------
Best Regards
Jett Zhou
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120706/03fc51f5/attachment-0001.html>
