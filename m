From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 17 Apr 2013 00:31:50 +0200
Subject: [PATCH v5 2/6] ARM: s3c64xx: Skip legacy EINT setup if
 pinctrl-s3c64xx driver is present
In-Reply-To: <20130416162642.GN26958@opensource.wolfsonmicro.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-3-git-send-email-tomasz.figa@gmail.com>
 <20130416162642.GN26958@opensource.wolfsonmicro.com>
Message-ID: <4730257.2Cvjq41NtX@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 of April 2013 17:26:43 Mark Brown wrote:
> On Mon, Apr 15, 2013 at 11:14:39PM +0200, Tomasz Figa wrote:
> > +	* This gpio driver includes support for device tree support and
> > there
> > +	* are platforms using it. In order to maintain compatibility with
> > those +	* platforms, and to allow non-dt Exynos4210 platforms to 
use
> > this +	* gpiolib support, a check is added to find out if there 
is a
> > active
> Cut'n'paste error here.

<blushed>

Thanks for catching this.

Best regards,
Tomasz
