From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 26 Jun 2013 14:46:22 +0100
Subject: [PATCH 3/4] arm: Add [U]EFI runtime services support
In-Reply-To: <20130625182021.GA29955@srcf.ucam.org>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-4-git-send-email-leif.lindholm@linaro.org>
 <20130625182021.GA29955@srcf.ucam.org>
Message-ID: <CACxGe6tjZT4TjWhYt+eA8RAwBrgJqW+Dto8t3rFgs8C_PbE9rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 7:20 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Jun 25, 2013 at 07:11:02PM +0100, Leif Lindholm wrote:
>> This patch implements basic support for UEFI runtime services in the
>> ARM architecture - a requirement for using efibootmgr to read and update
>> the system boot configuration.
>>
>> It also locates any presented SMBIOS configuration table and stores it
>> for potential later use by DMI.
>
> This appears to duplicate code that's already duplicated between x86 and
> ia64. We made a mistake there originally - let's not do it again. Having
> this code in three places is inevitably going to lead to skew and missed
> bugfixes.

+1

>
> --
> Matthew Garrett | mjg59 at srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
