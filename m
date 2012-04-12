From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 20:44:39 -0600 (MDT)
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <1331934707-29487-1-git-send-email-aneesh@ti.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
Message-ID: <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc Mark Greer, Mark Salter

Hi Greg, Aneesh,

On Sat, 17 Mar 2012, Aneesh V wrote:

> Add a driver for the EMIF SDRAM controller used in TI SoCs
> 
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.

Just checking to see what the current state of this series is.  Greg, are 
you considering this for merging, or are there remaining issues?  Aneesh, 
do you have any remaining issues to resolve with this set?

This is useful not only for OMAP4 and AM3517/3505, but also will probably 
be useful for the C6x chips that Mark Salter is working on.


- Paul
