From: dillonhua@gmail.com (Dillon)
Date: Sat, 14 Dec 2013 22:14:23 +0800
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
In-Reply-To: <1500417.9RFCmzklxv@flatron>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <CAOesGMifjnTDUcsweOwsw9fFgsE7b4q3wsASfP8YL-uMH5KiPA@mail.gmail.com>
 <CAPTRvHn7yTt6mC1fjEn5Ra9yx=GZ1DyNQtGWvHsDd_LkuiM_wA@mail.gmail.com>
 <1500417.9RFCmzklxv@flatron>
Message-ID: <6123E404-6FF7-466A-99C1-5F9CE30D8F50@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

  Let's me give some information about s3c6410 dev board in china,all of them are very cheap.

Ok6410
http://www.witech.com.cn/product/FL6410.html

Ut6410
http://go.ppwan.com/?pp_mid=10&sid=33242

Real6410
Http://www.realarm.cn/pic/?76_451.html

Arm sys 6410
http://www.hzlitai.com.cn/product/ARM/ARM6410/ARMSYS6410-L43T42.html


???? iPad

> ? 2013?12?14????8:41?Tomasz Figa <tomasz.figa@gmail.com> ???
> 
>> On Saturday 14 of December 2013 16:19:05 hua dillon wrote:
>> hi olof:
>> 
>>  i think mini6410 from china is the board you want .
> 
> There were several cheap boards with S3C6410 available, but I'm not sure
> how many of them are still on the market.
> 
> I guess Mini6410/Tiny6410 are, as I can at least see their prices there:
> http://www.andahammer.com/mini6410-sdk/
> http://www.andahammer.com/t6410sdk/
> 
> They are almost fully compatible, so they should be thought as just
> a single Mini6410 board, but in different form factors. I do most of
> my testing on the latter.
> 
> From other boards supported in mainline, there are:
> 
> - A&W6410 (mach-anw6410) - I couldn't find any information on it
>   anywhere,
> 
> - Wolfson Cragganmore 6410 - Mark Brown (copied) is using it for some
>   testing of audio codec AFAIK, but I'm not sure if you can get that
>   anywhere.
> 
> - HMT (mach-hmt), SmartQ 5/7 (mach-smartq*) - they are supposed to be
>   some tablet-like products, but again I'm not sure if you can still
>   get them,
> 
> - SMDK6400/SMDK6410 are Samsung's official development boards for
>   S3C6400/S3C6410 - I have access to one at the office; no idea if
>   you can get one anywhere,
> 
> - NCP - an abandoned Samsung's development board - you definitely
>   can't get that anywhere; in fact I'd say that there is no more such
>   board alive over the world and it just should be dropped from mainline.
> 
> That's all I can find at the moment. Anyway, I have copied Ben, maybe he
> knows more than that.
> 
> Best regards,
> Tomasz
> 
