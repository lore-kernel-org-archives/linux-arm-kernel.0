From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 23 Feb 2014 17:03:07 +0100
Subject: [PATCH v4 00/16] pinctrl: mvebu: restructure resource allocation
In-Reply-To: <20140223154053.GN7862@titan.lakedaemon.net>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140223154053.GN7862@titan.lakedaemon.net>
Message-ID: <530A1BBB.9060108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2014 04:40 PM, Jason Cooper wrote:
> Linus, Sebastian,
>
> On Sun, Feb 23, 2014 at 03:20:58PM +0100, Sebastian Hesselbarth wrote:
> ...
>> Also, in the meantime, pinctrl driver stubs for new Armada 375/38x have
>> been posted [4]. Compared to v3, this patch set now also takes care of
>> the new pinctrl stubs for Armada 375/38x. Those patches have been provided
>> by Thomas Petazzoni and make this patches depend on them. We have no stable
>> branch for the Armada 375/38x pinctrl patches but I guess Jason will provide
>> one soon.
>
> Linus,
>
> I certainly don't want to assume we can take this, and you've been quiet
> on the previous versions of this series.  We have a lot of moving pieces
> for getting the Armada 375/380/385 support added to the kernel.  It's a
> huge help to us if we can create a topic branch for you with the pinctrl
> changes in it.
>
> This allows us to get more testing in before the merge window and
> resolve conflicts before they land in arm-soc or mainline.  The
> resulting branch can then be sent through your tree or arm-soc,
> whichever you prefer.

I'd also prefer Jason creates a topic branch. It is all in
drivers/pinctrl/mvebu/ and as long as it stays there, we can have an
eye on it.

However, Linus did already mention he is happy with both, PR or his
Acked-by, on v2 of this patch set. I guess, it is Jason's call now if
he prefers PR or mvebu tree.

> Would you be okay with that?  We're already doing this for Mike (clk)
> and tglx (irqchip) and it works quite well.
>
> ...
>> The patches are based on 3.14-rc3. They are also available on an *unstable*
>> branch at
>
> Sebastian, Is there something you needed in v3.14-rc3 that isn't in
> v3.14-rc1?  If so, what exactly do these need?

Nope, sorry. Just wanted to make sure everybody realizes that the
unstable branch may lack clk-fixes/irqchip-fixes that have not been
into rc3 yet. It may influence testing experience but pinctrl does not
depend on it at all.

Sebastian
