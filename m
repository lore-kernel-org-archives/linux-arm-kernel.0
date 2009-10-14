From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Wed, 14 Oct 2009 21:33:33 +0100
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <20091014190333.GA28948@n2100.arm.linux.org.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
	<20091009165513.GA5902@n2100.arm.linux.org.uk>
	<4AD048A4.1070805@tuffmail.co.uk>
	<200910142021.59118.peter@peter-teichmann.de>
	<20091014190333.GA28948@n2100.arm.linux.org.uk>
Message-ID: <4AD6359D.7010303@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Oct 14, 2009 at 08:21:58PM +0200, Peter Teichmann wrote:
>   
>> I agree to Alan. It seems reasonable at least to include a stub as he 
>> suggests. However, since FastFPE was not updated for some years now, maybe 
>> the burden of maintaining patches is not so heavy in anymore? Maybe we can 
>> as well just include the latest version now? It becomes more and more 
>> difficult to find the source for someone who is interested in it.
>>     
>
> The easiest and least risky approach would be to leave it as is - we
> know it's not causing any problems with it there, and it's not causing
> any run-time bloat.
>   

Sure, if you don't like it, don't take it. All the patches in the 
"series" should stand on their own, with the exception of the last one 
(clearly labelled as "part 2" of the penultimate patch).

Hopefully, it should be trivial to establish the correctness of the 
patches 1 and 2 :-). But they are only cleanup attempts. The patch I 
really care about is the one I sent independently, "ARM: unexport 
symbols used to implement floating point emulation".

Regards
Alan
