From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Mar 2016 18:28:51 -0700
Subject: [PATCH v2 4/5] dt-bindings: ata: add compatible string for iProc
 AHCI controller
In-Reply-To: <1459140510-5317-5-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <56F9DA53.1090005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2016 21:48, Anup Patel a ?crit :
> The Broadcom iProc SoCs have AHCI compliant SATA controller. This
> patch adds common compatible string for AHCI SATA controller on
> iProc SoCs.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Tejun, should I queue this one through an arm-soc pull request or do you
want to take it via libata? Thanks!
-- 
Florian
