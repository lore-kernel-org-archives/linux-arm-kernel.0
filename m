From: laurent.desnogues@gmail.com (Laurent Desnogues)
Date: Thu, 10 Sep 2009 23:15:03 +0200
Subject: ARM linux mailing lists FAQ about floating point support.
In-Reply-To: <alpine.LFD.2.00.0909101659400.6044@xanadu.home>
References: <4AA94A40.408@xenomai.org>
	<alpine.LFD.2.00.0909101625120.6044@xanadu.home>
	<4AA9613F.5050103@xenomai.org>
	<alpine.LFD.2.00.0909101634520.6044@xanadu.home>
	<4AA967A3.2020107@xenomai.org>
	<alpine.LFD.2.00.0909101659400.6044@xanadu.home>
Message-ID: <761ea48b0909101415x233ae1fcka079b46b348028d1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 11:03 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:
>
>> Right, it does not work, so, what does:
>> "Allows the mixing of softfloat and hardfloat code"
>>
>> is supposed to mean here for instance:
>> http://www.eurotech-inc.com/embedded-eabi-linux.asp
>
> As I just posted, it looks like gcc only implemented the soft-float ABI
> when using VFP. ?So if your CPU is VFP capable then using
> -mfloat-abi=softfp should produce actual VFP instructions while still
> passing function arguments around using non VFP registers.

Didn't latest CodeSourcery ARM toolchain (2009q1) add hardfp?


Laurent
