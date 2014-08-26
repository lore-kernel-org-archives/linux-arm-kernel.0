From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 17:24:43 +0100
Subject: [PATCH 4/4] arm64: arch_timer: remove unused functions
In-Reply-To: <1408743797-7648-5-git-send-email-nathan_lynch@mentor.com>
References: <1408743797-7648-1-git-send-email-nathan_lynch@mentor.com>
 <1408743797-7648-5-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140826162443.GL16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 10:43:17PM +0100, Nathan Lynch wrote:
> The counter access and evtstream configuration are now done in common
> code, so remove the now-unused arch_counter_set_user_access and
> arch_timer_evtstrm_enable.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
