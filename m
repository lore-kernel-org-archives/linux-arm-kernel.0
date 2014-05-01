From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 May 2014 17:07:19 +0100
Subject: [PATCH] vexpress: Initialise the sysregs before setting up the
 clocks
In-Reply-To: <1398957275.3452.69.camel@linaro1.home>
References: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
 <1398957275.3452.69.camel@linaro1.home>
Message-ID: <20140501160718.GB28695@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 04:14:35PM +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-05-01 at 15:05 +0100, Catalin Marinas wrote:
> [...]
> > In addition, vexpress_sysreg_init() is changed to a device_initcall()
> 
> Not in this patch it isn't ;-)

Indeed, Pawel pinged me in private already. It was there initially but
it's not really justified for an -rc fix.

-- 
Catalin
