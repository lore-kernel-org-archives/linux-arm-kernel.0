From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Jul 2013 11:20:07 +0100
Subject: [PATCH v2] xen/arm and xen/arm64: update xen_restart after
 ff701306cd49
In-Reply-To: <1374486464-25243-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1374486464-25243-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130723102006.GB3748@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 10:47:44AM +0100, Stefano Stabellini wrote:
> Commit ff701306cd49 (arm64: use common reboot infrastructure) changes
> the prototype of arm_pm_restart.  Update xen_restart accordingly.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

You may even want to quote 7b6d864b48d9 (reboot: arm: change reboot_mode
to use enum reboot_mode) since you are changing a file under arch/arm ;)

-- 
Catalin
