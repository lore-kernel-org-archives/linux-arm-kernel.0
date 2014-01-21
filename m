From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Jan 2014 15:29:20 -0600
Subject: [PATCHv3 00/41] OMAPDSS: DT support v3
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <52DEE6B0.20106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomi,

On 01/21/2014 04:56 AM, Tomi Valkeinen wrote:
> Hi,
> 
> Here's version 3 of the DSS DT series.
> 
> The previous version can be found from:
> 
> v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
> v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866
> 
> The main changes to v2 are:
> 
> - DT Binding documentation
> - OMAP2 DSS support
> - Split DSI register space
> - DSS nodes disabled by default
> - Hack to have generic DT bindings but OMAP specific drivers (for now)
> 
> This series can also be found from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-review-3
> 
http://slexy.org/view/s20JhteOFR is my quick build test report -> few
checkpatch and build bisect issues would probably need fixing.



-- 
Regards,
Nishanth Menon
