From: yi.li@linaro.org (Yi Li)
Date: Thu, 31 Jul 2014 23:51:41 +0800
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAKv+Gu8Nq7-mhFPRqRw6sxDxZAz5kyLvDBwC_0E3qZp9ZpxPig@mail.gmail.com>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>	<CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>	<53DA509A.8070304@linaro.org>
 <CAKv+Gu8Nq7-mhFPRqRw6sxDxZAz5kyLvDBwC_0E3qZp9ZpxPig@mail.gmail.com>
Message-ID: <53DA660D.3070504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 31, 2014 10:26 PM, Ard Biesheuvel wrote:
> On 31 July 2014 16:20, Yi Li <yi.li@linaro.org> wrote:
>> Hi Ard,
>>
>>      The patch works well on FVP model, and here are the boot log and
>> dmidecode+lshw result:
>>
> Thanks Yi!
>
> Can we help Will out if he wants to test this himself?
     @Will: which platform do you have on hand?  I am using FVP model 
for testing.
     First, you need to merge SMBIOS support into UEFI.
     Then, compile and install the dmidecode(open source) on the linux 
,and run it.
