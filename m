From: lukma@denx.de (Lukasz Majewski)
Date: Mon, 6 Mar 2017 17:01:08 +0100
Subject: [PATCH 1/5] ARM: dts: am33xx: Add updated operating-points-v2
 table for cpu
In-Reply-To: <1488813822-26042-2-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-2-git-send-email-d-gerlach@ti.com>
Message-ID: <20170306170108.01994fde@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Mar 2017 09:23:38 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> After the ti-cpufreq driver has been added, we can now drop the
> operating-points table present in am33xx.dtsi for the cpu and add an
> operating-points-v2 table with all OPPs available for all silicon
> revisions. Also add necessary data for use by ti-cpufreq to
> selectively enable the appropriate OPPs at runtime as part of the
> operating-points table.
> 
> Information from AM335x Data Manual, SPRS717i, Revised December 2015,
> Table 5-7.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
