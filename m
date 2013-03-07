From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 09:22:58 +0000
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a
 constant delay clock
In-Reply-To: <20130307033221.GC25137@mudshark.cambridge.arm.com>
References: <20130306022308.GA21539@mudshark.cambridge.arm.com>
 <20130306183751.GV17833@n2100.arm.linux.org.uk>
 <20130307033221.GC25137@mudshark.cambridge.arm.com>
Message-ID: <20130307092258.GB17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 03:32:21AM +0000, Will Deacon wrote:
> Of course, this still isn't the right way to get patches into mainline and
> the points Russell makes above are completely correct. I wonder if we could
> extend the patch system to reject patches automatically if they don't appear
> in the linux-arm-kernel archives?

Ah, so what you're saying is that people can't be trusted to behave in a
responsible and professional manner. :)

How can that be done?  Parse the patch escaping all the special characters
as appropriate, passing it across to the ARM920T based list server, and
having that take a while to grep 600MB of linux-arm-kernel archive -
and have it fail because it got turned into quoted-printable or base64
encoded because of the UTF-8 used in the email message?

What you suggest sounds simple, but in practise it is a very hairy problem.
