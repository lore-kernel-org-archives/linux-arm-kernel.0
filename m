From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Oct 2013 14:39:29 -0400 (EDT)
Subject: [PATCH v2 0/3] ARM: NEON based fast(er) AES in CBC/CTR/XTS modes
In-Reply-To: <20131004182353.GQ12758@n2100.arm.linux.org.uk>
References: <1380837566-18242-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131004174853.GY24303@mudshark.cambridge.arm.com>
 <CAKv+Gu8RdiGw2+o-1ybGTx4fxaGnDQP7duhcFaLuxDphADjMaQ@mail.gmail.com>
 <20131004182353.GQ12758@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1310041435570.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Oct 2013, Russell King - ARM Linux wrote:

> Also, remember that the GPL says:
> 
> "The source code for a work means the preferred form of the work for
> making modifications to it."
> 
> So here's the question: is the assembly code the perferred form to make
> modifications?  From what you're saying above, the answer to that seems
> to be no.  Now, I'm not going to throw toys out of the pram and say
> that this is a hard requirement, but just take a moment to think about
> how we treat vendors who don't do this, instead supplying "non-preferred"
> forms of source code, and think about whether there's double standards
> here.
> 
> Now, while I can imagine that people have an ideological objection to
> perl (using comments like "write only code" etc) that's not a good
> enough excuse to avoid including the perferred form for future
> modification.
> 
> Now, we have mechanisms in the kernel build where we can include a
> prepared source which can be used to lessen the burden on the toolset
> required to build the kernel.  So, including both the perl script and
> the pre-generated assembly is entirely acceptable.  This tends to
> nullify the excuse that "we don't want to add additional tool burden
> to kbuild" argument.

Those are very good arguments.  And I agree with your recommendation as 
well.


Nicolas
