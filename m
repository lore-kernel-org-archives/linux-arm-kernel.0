From: sbabic@denx.de (Stefano Babic)
Date: Wed, 06 Aug 2014 17:52:58 +0200
Subject: [Regression] FEC: Panic on suspend in 3.16
In-Reply-To: <20140806154711.GQ30282@n2100.arm.linux.org.uk>
References: <53E24147.4050304@parkeon.com> <53E24525.2020809@mentor.com>
 <53E24A99.2020604@denx.de> <20140806154711.GQ30282@n2100.arm.linux.org.uk>
Message-ID: <53E24F5A.2000309@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 06/08/2014 17:47, Russell King - ARM Linux wrote:

> As Nathan says, the problem is caused by a71e3c37960c and the fix which
> will soon be merged into mainline and stable trees will be a revert of
> that commit.

I see. Thanks for explanation.

Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================
