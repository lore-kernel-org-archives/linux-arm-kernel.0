From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Mar 2010 01:08:52 +0000
Subject: [PATCH 2.6.34] USB: Fix s3c-hsotg build following Samsung
	platform header moves
In-Reply-To: <4B903B5A.3070204@simtec.co.uk>
	(sfid-20100304_225951_394090_46516C14)
References: <1267469502-19560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4B903B5A.3070204@simtec.co.uk>
	(sfid-20100304_225951_394090_46516C14)
Message-ID: <85D2F383-E25A-4F9C-8005-EB83B54F7BEE@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 Mar 2010, at 22:59, Ben Dooks <ben@simtec.co.uk> wrote:

> Mark Brown wrote:
>> Fix a reference to regs-sys.h got missed in the reorganisation of
>> the Samsung platform headers targetted for 2.6.34.
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> anyone mind if this gets merged into my next tree and given to RMK?

FWIW it'll lead to build breakage if merged seperately.

>
> -- 
> Ben Dooks, Design & Software Engineer, Simtec Electronics
>
> http://www.simtec.co.uk/
