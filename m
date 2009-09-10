From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 10 Sep 2009 22:54:59 +0200
Subject: ARM linux mailing lists FAQ about floating point support.
In-Reply-To: <alpine.LFD.2.00.0909101634520.6044@xanadu.home>
References: <4AA94A40.408@xenomai.org>
	<alpine.LFD.2.00.0909101625120.6044@xanadu.home>
	<4AA9613F.5050103@xenomai.org>
	<alpine.LFD.2.00.0909101634520.6044@xanadu.home>
Message-ID: <4AA967A3.2020107@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:
> 
>> Nicolas Pitre wrote:
>>> On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:
>>>
>>>> Hi,
>>>>
>>>> It seems the FAQ here:
>>>> http://www.arm.linux.org.uk/mailinglists/faq.php#f4
>>>>
>>>> is a bit outdated, since it does not mention that EABI solves the issue.
>>> And just how would EABI solve the issue?
>> By allowing to mix soft-float and hard-float programs with only one libc?
> 
> Err... How?

Right, it does not work, so, what does:
"Allows the mixing of softfloat and hardfloat code"

is supposed to mean here for instance:
http://www.eurotech-inc.com/embedded-eabi-linux.asp

-- 
					    Gilles.
