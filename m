From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 3 Jun 2013 16:34:20 +0100
Subject: [PATCH v5 0/4] xen/arm: CONFIG_PARAVIRT and stolen ticks
 accounting
In-Reply-To: <alpine.DEB.2.02.1305301426520.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301426520.4799@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1306031634050.4589@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Stefano Stabellini wrote:
> I am starting to be pretty confident about this patch series.
> 
> Please advice on what tree I should use to get this stuff upstream: most
> of the changes are Xen specific, but it also contains few generic ARM
> changes (the introduction of CONFIG_PARAVIRT and paravirt.c on ARM) and
> a couple of lines in kernel/sched/cputime.c (a missing include).

ping?
