From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:31:08 +0100
Subject: [RFC v3 10/10] KVM: arm/arm64: Emulate the EL1 phys timer
 registers
In-Reply-To: <1485970990-13775-11-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-11-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202103108.GI27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:10PM -0500, Jintack Lim wrote:
> Emulate read and write operations to CNTP_TVAL, CNTP_CVAL and CNTP_CTL.
> Now VMs are able to use the EL1 physical timer.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
