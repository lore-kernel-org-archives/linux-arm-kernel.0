From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 14 Dec 2013 04:41:06 -0800 (PST)
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
In-Reply-To: <CAPTRvHn7yTt6mC1fjEn5Ra9yx=GZ1DyNQtGWvHsDd_LkuiM_wA@mail.gmail.com>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <CAOesGMifjnTDUcsweOwsw9fFgsE7b4q3wsASfP8YL-uMH5KiPA@mail.gmail.com>
 <CAPTRvHn7yTt6mC1fjEn5Ra9yx=GZ1DyNQtGWvHsDd_LkuiM_wA@mail.gmail.com>
Message-ID: <1500417.9RFCmzklxv@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 of December 2013 16:19:05 hua dillon wrote:
> hi olof:
> 
>   i think mini6410 from china is the board you want .

There were several cheap boards with S3C6410 available, but I'm not sure
how many of them are still on the market.

I guess Mini6410/Tiny6410 are, as I can at least see their prices there:
http://www.andahammer.com/mini6410-sdk/
http://www.andahammer.com/t6410sdk/

They are almost fully compatible, so they should be thought as just
a single Mini6410 board, but in different form factors. I do most of
my testing on the latter.

>From other boards supported in mainline, there are:

 - A&W6410 (mach-anw6410) - I couldn't find any information on it
   anywhere,

 - Wolfson Cragganmore 6410 - Mark Brown (copied) is using it for some
   testing of audio codec AFAIK, but I'm not sure if you can get that
   anywhere.

 - HMT (mach-hmt), SmartQ 5/7 (mach-smartq*) - they are supposed to be
   some tablet-like products, but again I'm not sure if you can still
   get them,

 - SMDK6400/SMDK6410 are Samsung's official development boards for
   S3C6400/S3C6410 - I have access to one at the office; no idea if
   you can get one anywhere,

 - NCP - an abandoned Samsung's development board - you definitely
   can't get that anywhere; in fact I'd say that there is no more such
   board alive over the world and it just should be dropped from mainline.

That's all I can find at the moment. Anyway, I have copied Ben, maybe he
knows more than that.

Best regards,
Tomasz
