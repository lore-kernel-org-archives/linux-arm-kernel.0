From: davem@davemloft.net (David Miller)
Date: Thu, 14 Feb 2013 13:27:07 -0500 (EST)
Subject: [PATCH] ARM: net: bpf_jit: fix emit_swap16() for non ARMv6+.
In-Reply-To: <20130214150925.GI17833@n2100.arm.linux.org.uk>
References: <511C0662.8010309@gmail.com> <511CE939.5000705@freebox.fr>
 <20130214150925.GI17833@n2100.arm.linux.org.uk>
Message-ID: <20130214.132707.316192073342955090.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 14 Feb 2013 15:09:25 +0000

> On Thu, Feb 14, 2013 at 02:40:09PM +0100, Nicolas Schichan wrote:
>> On 02/13/2013 10:32 PM, Mircea Gherzan wrote:
>> [...]
>>> Acked-by: Mircea Gherzan <mgherzan@gmail.com>
>>
>> Hi,
>>
>> Thanks Mircea. Russel, David, do you have any preference as to which path 
>> this patch should take (net tree or ARM tree) ?
> 
> I'm happy for either - I'm under the weather at the moment, so I'd be
> greatful if David could pick this one up this time around.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied to 'net', thanks everyone.
