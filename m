From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Mar 2015 10:10:05 +0000
Subject: [PATCH v11 0/4] ARM: VDSO
In-Reply-To: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
References: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20150325101004.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 04:13:19PM -0500, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).

Okay, having re-read the code, I'm happy with this now.  I'll see about
testing it out on the platforms I have here in the next few days.  As
I now have a Cortex A15 platform, I can hopefully also check what effect
it has there (assuming ethernet gets fixed on it so I can get programs
onto the platform.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
