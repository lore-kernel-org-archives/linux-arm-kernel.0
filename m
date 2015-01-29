From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 29 Jan 2015 09:51:07 +0100
Subject: [PATCH v3 4/7] mmc: sdhci-pxav3: Modify clock settings for the
 SDR50 and DDR50 modes
In-Reply-To: <CAPDyKFpTnGrdKLYjH=GaG2bQ-44F68fSxRvRQBi8bHP5A83Ahw@mail.gmail.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>	<1422031587-18212-5-git-send-email-gregory.clement@free-electrons.com>
 <CAPDyKFpTnGrdKLYjH=GaG2bQ-44F68fSxRvRQBi8bHP5A83Ahw@mail.gmail.com>
Message-ID: <54C9F47B.1020200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

[...]

>> +               dev_warn(&pdev->dev, "conf-sdio3 register not found\n");
>> +               dev_warn(&pdev->dev, "disabling SDR50 and DDR50 modes\n");
>> +               dev_warn(&pdev->dev, "consider updating your dtb\n");
> 
> One dev_warn() should be enough. Also I don't think checkpatch
> complains about long lines for dev_warn().

Right. Once you will have told if you sill want a change or not in patch 1,
I will send a new version with this change.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
