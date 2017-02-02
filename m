From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:15:28 +0100
Subject: [RFC v3 06/10] KVM: arm/arm64: Update the physical timer
 interrupt level
In-Reply-To: <1485970990-13775-7-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-7-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202101528.GE27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:06PM -0500, Jintack Lim wrote:
> Now that we maintain the EL1 physical timer register states of VMs,
> update the physical timer interrupt level along with the virtual one.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
