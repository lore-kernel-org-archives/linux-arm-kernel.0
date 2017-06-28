From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Jun 2017 00:03:58 +0200
Subject: [alsa-devel] [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
In-Reply-To: <20170628195349.pqeb3dceddxar75s@sirena.org.uk> (Mark Brown's
 message of "Wed, 28 Jun 2017 20:53:49 +0100")
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
 <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
Message-ID: <87o9t7u5v5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Jun 19, 2017 at 01:57:20PM +0200, Robert Jarzmik wrote:
>
>> My serie shifted by one, so the very first of the serie is therefore missing,
>> formerly "ALSA: ac97: split out the generic ac97 registers" in
>> https://patchwork.kernel.org/patch/9398143/, and the shift triggered the
>> inclusion of the last patch of my tree, ie. yours :)
>
> Based on the missing first patch I was expecting the series to get
> reposted?
Hi Mark,

The first patch is only moving around a .h file. I was expecting a review before
reposting a v3.

Cheers.

-- 
Robert
