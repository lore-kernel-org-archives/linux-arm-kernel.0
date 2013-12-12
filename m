From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Dec 2013 14:59:52 +0800
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131211142431.GD596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131211141224.GG26730@mudshark.cambridge.arm.com>
 <20131211141503.GX11468@sirena.org.uk>
 <20131211142431.GD596@darko.cambridge.arm.com>
Message-ID: <52A95EE8.2060209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-11 22:24, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 02:15:03PM +0000, Mark Brown wrote:
>> On Wed, Dec 11, 2013 at 02:12:24PM +0000, Will Deacon wrote:
>>> I seem to remember Lorenzo having patches already for this, along with
>>> bindings, Documentation etc. so it would be good to know how these two
>>> series are supposed to interact.
>>
>> He said he hadn't had time to work on the actual implementation which is
>> why I picked this up - as far as I'm aware we only have the (already
>> merged) binding for this.
> 
> Lorenzo (on holiday now) pushed the DT topology bindings but there are
> no patches yet for reading them. I would much prefer to only describe
> the topology via DT rather than MPIDR (because hardware people sometimes
> have strange ideas).

Topology code for ARM32 is based on MPIDR now, should we update it too with
describing the topology via DT?

Thanks
Hanjun
