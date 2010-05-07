From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 May 2010 17:44:36 +0100
Subject: [PATCH 6/6] ARM: oprofile: convert from sysdev to platform device
In-Reply-To: <4BE2EC59.4060101@nokia.com>
References: <1271695361-7121-1-git-send-email-will.deacon@arm.com>
	<1271695361-7121-2-git-send-email-will.deacon@arm.com>
	<1271695361-7121-3-git-send-email-will.deacon@arm.com>
	<1271695361-7121-4-git-send-email-will.deacon@arm.com>
	<1271695361-7121-5-git-send-email-will.deacon@arm.com>
	<1271695361-7121-6-git-send-email-will.deacon@arm.com>
	<1271695361-7121-7-git-send-email-will.deacon@arm.com>
	<4BE2EC59.4060101@nokia.com>
Message-ID: <000001caee04$946afd80$bd40f880$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

> Will Deacon wrote:
> > This is a reworking of an original patch posted by Aaro Koskinen:
> >
> > oprofile does not work with PM, because sysdev_suspend() is done with
> > interrupts disabled and oprofile needs a mutex. Implementing oprofile
> > as a platform device solves this problem.
> >
> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> You can change this to Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks for this, I'll update the patch in the system.

Will
