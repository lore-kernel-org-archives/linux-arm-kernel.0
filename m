From: marek.belisko@gmail.com (Belisko Marek)
Date: Fri, 11 Mar 2011 13:23:37 +0100
Subject: [PATCH RFC] arm: mini2440: Fix uda134x codec problem.
In-Reply-To: <20110311121704.GF1760@opensource.wolfsonmicro.com>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
	<20110311121704.GF1760@opensource.wolfsonmicro.com>
Message-ID: <AANLkTintYQ=qO3PALBL-bkiYKQFw0+JiW3=-oZmkRhZ1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 1:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 09, 2011 at 09:46:20PM +0100, Marek Belisko wrote:
>> ASoC audio for mini2440 platform in current kenrel doesn't work.
>> First problem is samsung_asoc_dma device is missing in initialization.
>> Next problem is with codec. Codec is initialized but never probed
>
> Applied, thanks. ?With changes like this you should really split things
> up into a small patch series - if you ever find yourself writing
> "Next problem..." or "Also..." then going on to describe a separate
> change that's a sign that you should be writing a separate patch.
You're right. I think sending whole patch to help understand what
I'm trying to do (because wasn't sure). You apply just asoc part right?
Thanks for comments!
>

regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
