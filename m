From: lho@apm.com (Loc Ho)
Date: Wed, 12 Mar 2014 09:32:13 -0700
Subject: [PATCH v15 3/3] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <20140311165548.GA20776@mtj.dyndns.org>
References: <1394059489-30706-1-git-send-email-lho@apm.com>
 <1394059489-30706-2-git-send-email-lho@apm.com>
 <1394059489-30706-3-git-send-email-lho@apm.com>
 <1394059489-30706-4-git-send-email-lho@apm.com>
 <20140311124943.GD11477@htj.dyndns.org>
 <CAPw-ZTmBSeOXv5ExVAiSkcU=qH3zHp52eVuGBfYYD=7=sjhVgw@mail.gmail.com>
 <20140311165548.GA20776@mtj.dyndns.org>
Message-ID: <CAPw-ZT=xX9fi6zV8QFmCDAB7dvoLXSh+s1y_k9G0c44ONRbBOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> Kishon didn't applied the PHY DTS patch. Did you first apply the PHY
>> DTS patch? We agreed that you will first pull in the PHY DTS as well
>> as the host controller patches. I don't see any reason why it wouldn't
>> apply if both DTS is applied. I will pull libata/for-3.15 and check
>> out.
>
> Can you please repost patches to apply on top of the current
> libata/for-3.15?
>

I posted v16 yetersday with the PHY DTS merged into the SATA host patches.

-Loc
