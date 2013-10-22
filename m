From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 22 Oct 2013 11:27:32 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <5265AFED.1040503@roeck-us.net>
References: <52644A9E.3060007@wwwdotorg.org>	<20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
Message-ID: <52665314.2040904@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/13 23:51, Guenter Roeck wrote:
> In my opinion, not being able to describe behavior (or what people refer
> to as "describe how the hardware is used") is a severe limitation of
> devicetree usage in Linux. That is not a devicetree limitation per se,
> though, it is simply a matter of choice (or, in some cases, the ability
> of those arguing for new bindings to sell those bindings as "hardware
> description").

I agree this is a real problem, and I think it hinders upstream
submission, since platform data was permitted to describe behaviour as
well as describe the hardware, and platform data is being replaced with
DT which is only permitted to describe the hardware. How then should we
specify the behaviour to the kernel?

I've already mentioned specific examples of this on the "Clock DT
bindings" thread, and would be very interested if anybody has thoughts
about it:
http://lkml.kernel.org/r/520E1DF5.4030409 at imgtec.com

Cheers
James
