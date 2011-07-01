From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 01 Jul 2011 11:31:45 +0200
Subject: [PATCH 1/5] ASoC: wm8731: rework power management
In-Reply-To: <20110630152203.GB3249@opensource.wolfsonmicro.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<20110629171148.GB10798@opensource.wolfsonmicro.com>
	<4E0C80B8.7030006@atmel.com>
	<20110630152203.GB3249@opensource.wolfsonmicro.com>
Message-ID: <4E0D9401.1070300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/06/2011 17:22, Mark Brown :
> On Thu, Jun 30, 2011 at 03:57:12PM +0200, Nicolas Ferre wrote:
> 
> Please fix your mailer to line wrap within paragraphs.
> 
>> First of all, I experienced issues while not having OSC enabled during
>> suspend/resume cycle. Am I right supposing that, if using oscillator
>> to clock the codec, I have to keep it running during a suspend/resume
>> cycle?
> 
> No, not at all.  What makes you believe that you would you need to do
> that?

Ok, I re-tested and for sure I was totally wrong! So we forget this part
of the patch.
I guess that this belief may come from my first implementation on 2.6.35
where OSC was not part of the DAPM... Sory for the noise.

I repost the "active bit" part real-soon-now.

Thanks for your help, best regards,
-- 
Nicolas Ferre
