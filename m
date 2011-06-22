From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 22 Jun 2011 10:38:42 -0600
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <BANLkTi=fdg=f_mM87YOJGn--TUDVcGz7fA@mail.gmail.com>
References: <1308556402-10955-1-git-send-email-bs14@csr.com>
	<20110621162228.GI23234@n2100.arm.linux.org.uk>
	<BANLkTi=fdg=f_mM87YOJGn--TUDVcGz7fA@mail.gmail.com>
Message-ID: <BANLkTikP8WSSQbqre0UdKqWZjgp+TBOe9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 1:36 AM, Barry Song <21cnbao@gmail.com> wrote:
> so the problem still need to be solved since device names coming from DT is not
> that much "stable" as statically registered devices. the name from DT
> isn't the same
> as what board support code currently uses for statically registered
> platform_devices.
>
> Grant has two threads for this:
> 1. of: add clock providers to provide clk mapping in DT
> http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg03016.html
> 2. " If Linux needs specific devices to have specific names, then it
> can pass in a lookup table that matches DT nodes to device names,
> which is considerably simpler and it leaves the platform setup code in
> control over how devices get instantiated."
>
> both seems not ready yet?

I'm planning to merge the auxdata patch (thread 2 above) into
linux-next in a couple of days.  When I push out that branch, it can
be merged into the subarch tree before picking up the sirfprimall
support patch (assuming it gets picked up for v3.1)

g.
