From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 15:04:01 +0000
Subject: [PATCH RFC] CRYPTO: Fix more AES build errors:
In-Reply-To: <CAKv+Gu8sWLFnRZtuWOw2n96amAVc604Vk_HWD-9S6q1bZ5grhA@mail.gmail.com>
References: <E1Vylu8-0005Q9-MO@rmk-PC.arm.linux.org.uk>
 <CAKv+Gu9SrF_jkNc1ie+AX07YVGUdAYMGoKnJopFyirwh=acDVQ@mail.gmail.com>
 <CAKv+Gu8sWLFnRZtuWOw2n96amAVc604Vk_HWD-9S6q1bZ5grhA@mail.gmail.com>
Message-ID: <20140103150401.GQ7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 09:13:46AM +0100, Ard Biesheuvel wrote:
> I noticed that this patch has turned up in rmk/fixes.
> 
> Please be aware that by not updating the .S_shipped file in concert
> with the .pl file, we have a build time dependency on Perl now,
> something we tried to avoid when we discussed the original series
> http://marc.info/?l=linux-arm-kernel&m=138091140313491&w=2

Added, thanks for reminding me.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
