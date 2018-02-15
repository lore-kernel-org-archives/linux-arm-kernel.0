From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Feb 2018 11:53:45 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215104423.jj5msnd2evajzwpw@katana>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
 <20180214055800.od5yhgo753522yah@katana>
 <CAMuHMdU3opUTcOY-UeH4ArB+50_drPhGSoxP-m85p9V36fvTHg@mail.gmail.com>
 <ae3206a3-4735-87c8-9688-3acdbf06cc36@gmail.com>
 <CAMuHMdU4_wVcKwjB1ZQzfgp8vCDs92F1o+v4UyZ0bsRDfJD1vQ@mail.gmail.com>
 <15de7079-f43e-1e76-2a99-7232498b077a@gmail.com>
 <20180215104423.jj5msnd2evajzwpw@katana>
Message-ID: <064d2718-804c-dd75-5b24-b4c3175b3b7a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2018 11:44 AM, Wolfram Sang wrote:
> 
>>> BTW, several PPC platforms use of_device_compatible_match(of_root, ...),
>>> but I believe of_root is not guaranteed to be set up.
>>
>> OK, subsequent patch then. Added to TODO.
> 
> Can you place it below the PCIE patches, please? ;)

Grumble, yeah.

-- 
Best regards,
Marek Vasut
