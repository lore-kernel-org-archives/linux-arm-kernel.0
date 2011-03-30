From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Mar 2011 20:19:38 +0100
Subject: /proc/cpu/clocks
In-Reply-To: <AANLkTikBgq0bSRSQRSzeu==ByemegSB+x7AXXeJjR_ct@mail.gmail.com>
References: <AANLkTikBgq0bSRSQRSzeu==ByemegSB+x7AXXeJjR_ct@mail.gmail.com>
Message-ID: <20110330191938.GE2939@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 11:27:46AM -0500, Matt Sealey wrote:
> Where did /proc/cpu/clocks go in the kernel and where can I find the
> equivalent information?

It has never existed as a generic thing in mainline.  If some platform
added it then it was private to that platform.
