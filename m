From: tj@kernel.org (Tejun Heo)
Date: Tue, 11 Mar 2014 12:55:48 -0400
Subject: [PATCH v15 3/3] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <CAPw-ZTmBSeOXv5ExVAiSkcU=qH3zHp52eVuGBfYYD=7=sjhVgw@mail.gmail.com>
References: <1394059489-30706-1-git-send-email-lho@apm.com>
 <1394059489-30706-2-git-send-email-lho@apm.com>
 <1394059489-30706-3-git-send-email-lho@apm.com>
 <1394059489-30706-4-git-send-email-lho@apm.com>
 <20140311124943.GD11477@htj.dyndns.org>
 <CAPw-ZTmBSeOXv5ExVAiSkcU=qH3zHp52eVuGBfYYD=7=sjhVgw@mail.gmail.com>
Message-ID: <20140311165548.GA20776@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Loc.

On Tue, Mar 11, 2014 at 08:51:37AM -0700, Loc Ho wrote:
> Kishon didn't applied the PHY DTS patch. Did you first apply the PHY
> DTS patch? We agreed that you will first pull in the PHY DTS as well
> as the host controller patches. I don't see any reason why it wouldn't
> apply if both DTS is applied. I will pull libata/for-3.15 and check
> out.

Can you please repost patches to apply on top of the current
libata/for-3.15?

Thanks.

-- 
tejun
