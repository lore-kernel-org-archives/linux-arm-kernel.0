From: chris@printf.net (Chris Ball)
Date: Thu, 22 May 2014 13:34:41 +0100
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
In-Reply-To: <CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 22 May 2014 14:15:09 +0200")
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
 <86zjiaqarn.fsf@void.printf.net>
 <CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
Message-ID: <86sio2q9em.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 22 2014, Ulf Hansson wrote:
> "mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function"
>
> The following lines...
> +       else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
> +                (ios->timing == MMC_TIMING_MMC_DDR52))
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>
> Should be replaced by;
> +       else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +                (timing == MMC_TIMING_MMC_DDR52))
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;

Done and pushed out, thanks.

- Chris.
-- 
Chris Ball   <http://printf.net/>
