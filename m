From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 2 Jun 2018 11:07:40 -0300
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
In-Reply-To: <CAOf5uwneWyjNpD-tGGL7CgL2_jJFvDtzbi+NBg7wqGMGR4qGCw@mail.gmail.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
 <CAOMZO5BVhjwGpJ22qBihKcjWyvBkzNPU0cNtNY9HToLLEkYByA@mail.gmail.com>
 <CAOf5uwneWyjNpD-tGGL7CgL2_jJFvDtzbi+NBg7wqGMGR4qGCw@mail.gmail.com>
Message-ID: <CAOMZO5DfpwEDrBrMaTCt1_2Kkkm_tuVLE2WMy5z2=iO_rRFVEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sat, Jun 2, 2018 at 11:04 AM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> ull is a preatty new platform so one board was listed. Are you sure
> that we need?

There are several imx6ul based dts in mainline and it is better if we
can avoid dtb breakage when possible.

In this case we can avoid the dtb breakage by adding the new clock
definitions at the end of the file, just like we do for all the other
imx devices.
