From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Oct 2013 16:22:38 +0200
Subject: [PATCH v3 03/14] ARM: mvebu: ll_set_cpu_coherent always uses
 the current CPU
In-Reply-To: <1381759106-15004-4-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
 <1381759106-15004-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131014162238.1a332e4e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:15 +0200, Gregory CLEMENT wrote:
> ll_set_cpu_coherent is always used on the current CPU, so instead of
> passing the CPU id as argument, ll_set_cpu_coherent() can find it by
> itself.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Of course, it depends of PATCH 02/14, which I don't agree with at
the moment, but I am fine with this PATCH 03/14.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
