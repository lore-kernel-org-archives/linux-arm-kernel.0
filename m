From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 14 Jun 2013 14:04:00 +0100
Subject: [RFC PATCH v3 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <20130613225233.GB22310@quad.lixom.net>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370512763-32200-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130613225233.GB22310@quad.lixom.net>
Message-ID: <1371215040.3154.6.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-13 at 23:52 +0100, Olof Johansson wrote:
> > +     reg = <0 0x7FFF0000 0 0x1000>;
> 
> #size-cells 2 on the parent bus? That's somewhat unusual. 

LPAE == 40 bit physical addresses == potential > 32 bit sizes (memory
blocks > 4GB)

Pawe?
