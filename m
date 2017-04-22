From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 Apr 2017 13:43:41 +0200
Subject: [PATCH v2 0/5] mtd: nand: gpmi: add i.MX 7 support
In-Reply-To: <20170422012338.4635-1-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
Message-ID: <69b1b198-8172-4b01-11ad-25e88b5e7a6e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2017 03:23 AM, Stefan Agner wrote:
> This patchset adds support for i.MX 7 SoC for the GPMI NAND controller.
> There have been similar patchsets already:
> https://lkml.org/lkml/2016/2/23/912
> 
> However, this patchset does not make use of any of the new features.
> The current feature set seems to work fine, I successfully run the MTD
> tests on a Colibri iMX7.
> 
> --
> Stefan
> 
> Changes since v1:
> - Make clks_count const
> - Introduce IS_IMX7D for i.MX 7 SoC's and make it part of GPMI_IS_MX6

Super, thanks.

-- 
Best regards,
Marek Vasut
