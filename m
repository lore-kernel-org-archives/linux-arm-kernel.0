From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Apr 2017 04:33:04 +0200
Subject: [PATCH 0/5] mtd: nand: gpmi: add i.MX 7 support
In-Reply-To: <20170421010755.18025-1-stefan@agner.ch>
References: <20170421010755.18025-1-stefan@agner.ch>
Message-ID: <644017ff-7b26-143c-df2f-1223841c81f4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 03:07 AM, Stefan Agner wrote:
> This patchset adds support for i.MX 7 SoC for the GPMI NAND controller.
> There have been similar patchsets already:
> https://lkml.org/lkml/2016/2/23/912
> 
> However, this patchset does not make use of any of the new features.
> The current feature set seems to work fine, I successfully run the MTD
> tests on a Colibri iMX7.
> 
> --

The rest of the patchset is IMO OK too, but you probably want the DT
changes Acked by Shawn or Fabio.

-- 
Best regards,
Marek Vasut
