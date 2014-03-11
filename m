From: lho@apm.com (Loc Ho)
Date: Tue, 11 Mar 2014 08:51:37 -0700
Subject: [PATCH v15 3/3] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <20140311124943.GD11477@htj.dyndns.org>
References: <1394059489-30706-1-git-send-email-lho@apm.com>
 <1394059489-30706-2-git-send-email-lho@apm.com>
 <1394059489-30706-3-git-send-email-lho@apm.com>
 <1394059489-30706-4-git-send-email-lho@apm.com>
 <20140311124943.GD11477@htj.dyndns.org>
Message-ID: <CAPw-ZTmBSeOXv5ExVAiSkcU=qH3zHp52eVuGBfYYD=7=sjhVgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

>> This patch adds APM X-Gene SoC AHCI SATA host controller DTS entries.
>
> I pulled the phy branch into libata/for-3.15 but this patch fails to
> apply.  Can you please regenerate the patches which need to be applied
> on top of libata/for-3.15.
>

Kishon didn't applied the PHY DTS patch. Did you first apply the PHY
DTS patch? We agreed that you will first pull in the PHY DTS as well
as the host controller patches. I don't see any reason why it wouldn't
apply if both DTS is applied. I will pull libata/for-3.15 and check
out.

-Loc
