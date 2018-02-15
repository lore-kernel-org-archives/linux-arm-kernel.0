From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Feb 2018 10:36:23 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <CAMuHMdX625D9+U1r_OnQyhwrtMBz-kdc-xtoLMtjv+Gk84p+zQ@mail.gmail.com>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdX625D9+U1r_OnQyhwrtMBz-kdc-xtoLMtjv+Gk84p+zQ@mail.gmail.com>
Message-ID: <2edd31a0-c9d5-fafa-2bac-37d5fefb80af@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2018 10:14 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Wed, Feb 14, 2018 at 12:28 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Regulator setup is suboptimal on H2 Stout too.
> 
> Worse, Stout has 2 DA9210 regulators, so you have to add a check for a
> DA9210 at address 0x70.

Fixed

-- 
Best regards,
Marek Vasut
