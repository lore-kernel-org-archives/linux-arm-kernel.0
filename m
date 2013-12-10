From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 10 Dec 2013 14:20:09 +0100
Subject: [PATCH v6 00/17] add COMMON_CLK support for PowerPC MPC512x
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Message-ID: <20131210132009.GR2982@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ trimmed Cc: list to PowerPC and CCF ]

On Sat, Nov 30, 2013 at 23:51 +0100, Gerhard Sittig wrote:
> 
> this series introduces support for the common clock framework (CCF,
> COMMON_CLK Kconfig option) in the PowerPC based MPC512x platform,
> which brings device tree based clock lookup as well

For the record:  MPC5125 turned out to be quite different
compared to MPC5121/5123 with regard to the set of peripherals
and clock features, so I sent an update of this COMMON_CLK
support motivated by MPC5125:

  From: Gerhard Sittig <gsi@denx.de>
  To: linuxppc-dev at lists.ozlabs.org, linux-arm-kernel at lists.infradead.org,
    Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
    Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
  Cc: Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>,
    Gerhard Sittig <gsi@denx.de>
  Subject: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
  Date: Tue, 10 Dec 2013 14:11:33 +0100
  Message-Id: <1386681097-14126-1-git-send-email-gsi@denx.de>


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
