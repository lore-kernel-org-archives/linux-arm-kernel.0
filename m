From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 16:17:24 -0500
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
In-Reply-To: <20131113132952.GK878@sirena.org.uk>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
 <20131113132952.GK878@sirena.org.uk>
Message-ID: <52911B64.3020009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wednesday 13 November 2013 08:29 AM, Mark Brown wrote:
> On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
>> On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie@kernel.org> wrote:
> 
>>> Applied, thanks.
> 
>> These warnings are showing up (again?), so wherever it was applied is
>> not making it into -next. Did it fall between the cracks?
> 
> Looks lie it never got pushed and nobody looked at the warnings for over
> a month.  Oh well, sorry about that.
> 
Are you going to push this one ? The warning is still showing up at
3.13-rc1.

Regards,
Santosh 
