From: oss@buserror.net (Scott Wood)
Date: Wed, 23 Nov 2016 01:07:13 -0600
Subject: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
In-Reply-To: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
References: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
Message-ID: <1479884833.21746.44.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-10-25 at 10:15 +0800, Jia Hongtao wrote:
> From: Hongtao Jia <hongtao.jia@nxp.com>
> 
> Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
> sensor specifier added is the monitoring site ID, and represents the "n" in
> TRITSRn and TRATSRn.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>

Where can I find this new binding? ?As of the current linux-next I don't see
anything in qoriq-thermal.txt about this.

-Scott
