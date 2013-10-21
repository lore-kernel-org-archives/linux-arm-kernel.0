From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Oct 2013 21:24:20 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131021170711.GA5256@netboy>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com> <20131021170711.GA5256@netboy>
Message-ID: <52658D74.3010504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 06:07 PM, Richard Cochran wrote:
> On Mon, Oct 21, 2013 at 11:15:56AM +0200, Thierry Reding wrote:
>>
>> Right now, we're taking away much of that flexibility and I see progress
>> on ARM actively hindered.
> 
> Baloney.
> 
> No one is taking away your flexibility or hindering progress. It is
> really very simple. Just make an arm-dt-devel tree where you can both
> change the bindings at will and recommend to people. Once bindings
> have seen some real world testing and have had time to mature, then
> request a merge into mainline.

Thierry already has working patches for LCD support, and the "request
[for] a merge into mainline" is just "send the patch to be applied to
mainline", which he did, and was blocked on, because of the potential
existance of CDF if the future.
