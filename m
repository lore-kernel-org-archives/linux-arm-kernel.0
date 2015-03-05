From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 5 Mar 2015 16:52:34 +0100
Subject: [PATCH v2 5/9] ARM: at91: add soc detection infrastructure
In-Reply-To: <1425580851.g2DuYFu1co@ws-stein>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425557486-3534-6-git-send-email-alexandre.belloni@free-electrons.com>
 <1425580851.g2DuYFu1co@ws-stein>
Message-ID: <20150305155234.GU3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2015 at 16:29:26 +0100, Alexander Stein wrote :
> > +	if (!regs) {
> > +		pr_warn("Could not map DBGU iomem range");
> > +		iounmap(regs);
> 
> I guess if regs == NULL there is no need to iounmap them, no?
> 

Indeed :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
