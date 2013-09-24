From: leoy@marvell.com (Leo Yan)
Date: Tue, 24 Sep 2013 10:00:38 +0800
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <20130923152606.GA6157@e102648.cambridge.arm.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
 <524021EC.2000207@marvell.com>
 <20130923152606.GA6157@e102648.cambridge.arm.com>
Message-ID: <5240F246.6050402@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/23/2013 11:26 PM, Achin Gupta wrote:

> The foundation model (if thats what you are using) does not model an
> ARM cpu implementation. The CPUECTLR is a cpu specific register
> (imp. def.)  so it is not present. The caches on the Foundation Model
> are inherently coherent so you do not need to access this register. If
> you do then the access is treated as an illegal instruction.
>

Thx for the info. So do u mean i need use FVP Model for A53?

Here have another question, ARM have the example code for boot wrapper 
which will switch from EL3 to secure EL1 rather than non-secure's EL1?

Thx,
Leo Yan
