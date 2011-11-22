From: jbaron@redhat.com (Jason Baron)
Date: Tue, 22 Nov 2011 18:50:41 -0500
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20111122233949.GA24453@redhat.com>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
 <4ECC2A07.8050701@codeaurora.org>
 <20111122233949.GA24453@redhat.com>
Message-ID: <20111122235041.GB24453@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:39:50PM -0500, Jason Baron wrote:
> Right, for jump labels we have a script at: scripts/gcc-goto.sh, which
> basically just checks if we can compile 'asm goto' without error, so for
> %c, you could probably have some simple 'asm()' that uses %c, and see if
> it compiles. Although, I'm not sure if there's a arch specific dir, for
> such a thing?
> 
> thanks,
> 
> -Jason

hmm...actually we could add it to the top level scripts/gcc-goto.sh,
that would be fine, I can take a look at that...

-Jason
