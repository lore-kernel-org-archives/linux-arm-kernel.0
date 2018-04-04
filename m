From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 04 Apr 2018 15:30:14 +0100
Subject: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
In-Reply-To: <20180404155909.148085f7@dell-desktop.home>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-8-mylene.josserand@bootlin.com>
 <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
 <20180404155909.148085f7@dell-desktop.home>
Message-ID: <86vad7qc21.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Apr 2018 14:59:09 +0100,
Myl?ne Josserand wrote:

> > It'd be good to take this opportunity to refactor the shmobile code.
> 
> I can do it in this series but I do not have any shmobile platforms so
> I will not be able to test my modifications (only compilation).
> 
> If someone can test it for me (who?), it is okay for me to refactor this
> code :)

I guess you could Cc the shmobile folks (Geert Uytterhoeven, Simon
Horman), and get them to review/test the changes.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
