From: vishwanath.bs@ti.com (Sripathy, Vishwanath)
Date: Sat, 24 Sep 2011 10:54:29 +0530
Subject: [PATCHv9 00/18] omap PRCM chain handler
In-Reply-To: <35343.1316816580@turing-police.cc.vt.edu>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
	<35343.1316816580@turing-police.cc.vt.edu>
Message-ID: <CA+mksuDD=7Zf1bhmdq_Ficz_ZQEdiE5GLOGH18Cgf+XEmCd74w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valdis.Kletnieks,

On Sat, Sep 24, 2011 at 3:53 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 23 Sep 2011 15:46:08 +0300, Tero Kristo said:
>> Following set contains the version 9 of this work. This patch set contains
>> a number of patches tagged as 'TEMP', they are only meant for testing
>> purposes and to provide proof of concept. Most of the 'TEMP' patches are
>> related to UART runtime handling and they will be replaced by work done
>> by Govindraj Raja.
>
> What do we do with these TEMP patches if the UART patches don't make the same
> merge window, or have other issues? ?I'm always leery of "will be replaced"
> code, because I've seen too many times when it *didn't* get replaced.
>
> (I really don't care what the 'Plan B' is, as long as we have one...)
UART Runtime patches are already posted for review and it's also
targeted for next merge window. Our intention is to push both the
features together for next merge window.

Regards
Vishwa

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
