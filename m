From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 30 Jun 2017 17:06:01 +0200
Subject: [alsa-devel] [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
In-Reply-To: <20170630115600.btemrql3aso4s45z@sirena.org.uk> (Mark Brown's
 message of "Fri, 30 Jun 2017 12:56:00 +0100")
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
 <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
 <87o9t7u5v5.fsf@belgarion.home>
 <20170630115600.btemrql3aso4s45z@sirena.org.uk>
Message-ID: <87k23ttt0m.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Jun 29, 2017 at 12:03:58AM +0200, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > Based on the missing first patch I was expecting the series to get
>> > reposted?
>
>> The first patch is only moving around a .h file. I was expecting a review before
>> reposting a v3.
>
> I can't tell what's in the first patch if you didn't send it.... :(
> In general it's best to resend for things like this, I know I focus my
> review on things that can progress as-is.
OK, no problem, I'll resend a v2 resend in the following hours.

Cheers.

-- 
Robert
