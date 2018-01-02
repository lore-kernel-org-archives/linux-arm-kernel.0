From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 2 Jan 2018 17:07:11 +0100
Subject: [PATCH v2 0/8] Armada 7K/8K CP110 DT de-duplication
In-Reply-To: <87373ocm5n.fsf@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
 <87373ocm5n.fsf@free-electrons.com>
Message-ID: <20180102170711.3c76e0e8@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 02 Jan 2018 16:31:32 +0100, Gregory CLEMENT wrote:

> I applied all the series on mvebu/dt64. The only change I made was
> adding a commit log to the patch 3:
> "Fix the same typo duplicated in both master and slave version of
> armada-cp110-*.dtsi file: s/limiation/limitation/."

Thanks!

I would recommend you to ask people submitting DT changes for this
cycle to base their changes on your mvebu/dt64 branch, because most DT
changes for 7K/8K are going to conflict with this de-duplication +
renaming patch series.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
