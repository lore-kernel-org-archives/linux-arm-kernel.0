From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 May 2016 12:56:15 -0700
Subject: [PATCH 1/2] arm64: dts: NS2: Add all of the UARTs
In-Reply-To: <57391E45.8010209@huawei.com>
References: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
 <57341FCE.6050403@huawei.com>
 <CAC3K-4qbkt3DCgd6qurNo3V+++x70bbFC--aunR0DbCTBvBNZg@mail.gmail.com>
 <57353761.5020409@huawei.com>
 <CAC3K-4oXcwR--879sCFR=MCG1Uman7DoGvaHLVXWr+0QH2WeJg@mail.gmail.com>
 <57391E45.8010209@huawei.com>
Message-ID: <573B775F.4060503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2016 06:11 PM, Kefeng Wang wrote:
>> I can confirm that with your change and the change to the bootargs you describe above, it works as desired.  Was your change already accepted?
>>
> 
> Great, thanks a lot. it is still being reviewing for now and waiting for response for now.

Then I would be inclined to take Jon's patch as-is, and follow up with
an additional patch to the NS2 DTS once yours lands in.
-- 
Florian
