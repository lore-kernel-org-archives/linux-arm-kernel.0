From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jul 2015 18:08:55 +0100
Subject: [PATCH v3 08/11] KVM: arm: implement dirty bit mechanism for
 debug registers
In-Reply-To: <123AABA4-2C79-462D-91FC-56FB52DB972C@linaro.org>
References: <1434969694-7432-1-git-send-email-zhichao.huang@linaro.org>
 <1434969694-7432-9-git-send-email-zhichao.huang@linaro.org>
 <20150630092020.GP11332@cbox>
 <B3B5AB0D-020C-483D-A6DE-76E355865010@linaro.org>
 <20150703115611.GB14220@lvm>
 <5A7DE9A0-E7A6-40B0-80F9-896F7DED0E47@linaro.org>
 <20150707102405.GE23879@arm.com>
 <123AABA4-2C79-462D-91FC-56FB52DB972C@linaro.org>
Message-ID: <20150708170855.GB6348@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 11:50:22AM +0100, Zhichao Huang wrote:
> Are you happy with this?:

You miss the reserved breakpoint, I think.
I also still don't understand why this is preferable to trapping.

Will
