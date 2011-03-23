From: dima@android.com (Dima Zavin)
Date: Wed, 23 Mar 2011 12:18:52 -0700
Subject: [PATCH 09/20] video: msm: Split out MDP2.2 HW specific code.
In-Reply-To: <1300885912.6117.16.camel@m0nster>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485423-27281-1-git-send-email-carlv@codeaurora.org>
	<1300885912.6117.16.camel@m0nster>
Message-ID: <AANLkTimYqxt1q2Ca8meEYdM0yGEHWoBqdTTDU0GXC5ge@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +config MSM_MDP22
>> + ? ? ? bool
>> + ? ? ? depends on ARCH_MSM7X00A
>> + ? ? ? default y
>> +
>
> You should remove the "default y" and this should be moved to a Kconfig
> under video (shouldn't be added into mach-msm).

Additionally, please have the right MDP version directly 'select'ed by
the ARCH_XXXX definitions instead of doing the 'depends on' business.

--Dima

>
> Daniel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
